from prometheus_client import Counter, Gauge, Summary, Histogram, Info, Enum

#v-- Only increases
prometheusCounter1 = Counter(
    'counter1', 
    'Counter1 description',
    ['label1', 'label2']
)
#! Best practice: initialize labels so they are always exist
prometheusCounter1.labels(label1='label1_value', label2='label2_value').inc(0)



#v-- Both Increatses and Decreases
prometheusGauge = Gauge(
    'gauge1', 
    'Gauge1 description',
    ['label1', 'label2']
)

#v-- ???
prometheusSummary1 = Summary(
    'summary1', 
    'Summary1 description',
    ['label1', 'label2']
)



#v-- ???
prometheusHistogram1 = Histogram(
    'histogram1', 
    'Histogram1 descriptions',
    ['label1', 'label2']
)



#v-- Map
prometheusInfo1 = Info(
    'info1', 
    'Description of info',
    ['label1', 'label2']
)



#v-- Enum
prometheus_enum1 = Enum(
    'enum1',
    'Enum1 description',
    ['label1', 'label2'],
    states = [
        'state1',
        'state2',
        'state3'
    ]
)