package com.example;

import org.apache.flink.api.common.serialization.SimpleStringSchema;
import org.apache.flink.api.common.typeinfo.TypeInformation;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.connectors.kinesis.FlinkKinesisConsumer;
import org.apache.flink.streaming.api.windowing.assigners.TumblingEventTimeWindows;
import org.apache.flink.streaming.api.datastream.DataStream;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.functions.timestamps.AscendingTimestampExtractor;

import java.util.Properties;

public class FlinkJob {
    public static void main(String[] args) throws Exception {
        final StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        env.setParallelism(2);

        Properties props = new Properties();
        props.setProperty("aws.region", "us-east-1");
        props.setProperty("flink.stream.initpos", "LATEST");

        FlinkKinesisConsumer<String> consumer =
                new FlinkKinesisConsumer<>("infraestructura-transporte-kinesis-aws-dev-event-stream",
                        new SimpleStringSchema(), props);

        DataStream<String> stream = env.addSource(consumer);

        // Asignar timestamps (ejemplo: columna 4 del CSV)
        SingleOutputStreamOperator<String[]> parsed = stream
                .map(line -> line.split(","))
                .returns(TypeInformation.of(String[].class))
                .assignTimestampsAndWatermarks(new AscendingTimestampExtractor<String[]>() {
                    @Override
                    public long extractAscendingTimestamp(String[] element) {
                        return Long.parseLong(element[3]); // timestamp
                    }
                });

        // Ventana tumbling de 1 minuto
        parsed
            .keyBy(e -> e[0] + "-" + e[1]) // sensor_id + metric_type
            .window(TumblingEventTimeWindows.of(org.apache.flink.streaming.api.windowing.time.Time.minutes(1)))
            .reduce((a, b) -> new String[]{
                a[0], a[1],
                String.valueOf(Double.parseDouble(a[2]) + Double.parseDouble(b[2])),
                a[3]
            })
            .map(e -> String.format("Sensor: %s, Metric: %s, Avg: %.2f",
                    e[0], e[1], Double.parseDouble(e[2]) / 2))
            .print();

        env.execute("Flink Sensor Processing");
    }
}