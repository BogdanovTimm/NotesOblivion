from prometheus_client import disable_created_metrics
import prometheus_client

#v-- Disable stupid metrics
disable_created_metrics()
prometheus_client.REGISTRY.unregister(prometheus_client.GC_COLLECTOR)
prometheus_client.REGISTRY.unregister(prometheus_client.PLATFORM_COLLECTOR)
prometheus_client.REGISTRY.unregister(prometheus_client.PROCESS_COLLECTOR)
#^-- Disable stupid metrics