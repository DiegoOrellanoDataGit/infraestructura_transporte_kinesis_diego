# Pre-entrega 4: Procesamiento en Tiempo Real con Apache Flink

## 📌 Objetivo
Desarrollar y desplegar una aplicación de **Managed Service for Apache Flink** que implemente lógica **stateful** sobre la infraestructura de ingesta existente.  
El foco está en:
- Consumo y deserialización desde **Amazon Kinesis Data Streams**.
- Implementación de **Watermarks** y manejo de **Event Time**.
- Procesamiento **stateful** con ventanas temporales.
- Configuración de **checkpoints en S3** para tolerancia a fallos.
- Monitoreo con **CloudWatch Logs**.

---

## ⚙️ Lógica de la Aplicación

### 1. Consumo y Deserialización
La aplicación se conecta al **Kinesis Data Stream** creado en el Módulo 2 y deserializa los eventos en formato JSON.

### 2. Lógica Temporal
Se implementa un `WatermarkStrategy` con tolerancia al desorden natural de la red.  
Esto asegura que los eventos tardíos sean manejados correctamente sin perder datos relevantes.

### 3. Procesamiento Stateful
Se utiliza:
- **TumblingEventTimeWindows** de 1 minuto para agregaciones.  
- **KeyedState** para mantener métricas por partición (ejemplo: conteo de eventos por clave).

### 4. Tolerancia a Fallos
Se habilitan **checkpoints en S3** con el siguiente codigo:
checkpoint_configuration {
  configuration_type = "CUSTOM"
  checkpointing_enabled = true
  checkpoint_interval  = 60000
  min_pause_between_checkpoints = 5000
  s3_configuration {
    bucket_arn = var.checkpoint_bucket_arn
  }
}

### 5. Estructura del proyecto 
infraestructura_transporte_kinesis_aws/
├── artefacto/                # Código fuente Flink (Java/Scala/Python)
│   └── target/flink-job.jar
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── prod/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── policies/
│   └── firehose.json
└── README.md
