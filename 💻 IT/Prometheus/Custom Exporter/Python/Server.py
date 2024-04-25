from prometheus_client import start_http_server, disable_created_metrics, Counter, Gauge, Summary, Histogram, Info, Enum
import time

#v-- Both Increatses and Decreases
prometheusGauge = Gauge(
    'gauge1', 
    'Gauge1 description',
    ['label1', 'label2']
)
prometheusGauge.labels(label1='label1_value', label2='label2_value').set(0)

# Calls process_request() single-threadly. How often depends on time.sleep()
if __name__ == '__main__':
    start_http_server(55551)
    while True:
        time.sleep(5) # How often to gather metrics
        prometheusGauge.labels(label1='label1_value', label2='label2_value').inc(1)