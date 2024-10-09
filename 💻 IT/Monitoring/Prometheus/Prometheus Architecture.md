#                  Prometheus Architecture

```
 System-Stats   |    Applicaiton-Stats    |   Custom-Stats
 ---------------+-------------------------+---------------------
      ^                      ^                     ^
   HTTP-GET               HTTP-GET              HTTP-GET
      |                      |                     |
+---------------+  +----------------------+  +-----------------+
| node_exporter |  | application_exporter |  | custom_exporter |
+---------------+  +----------------------+  +-----------------+
             ^               ^                 ^
          HTTP-GET        HTTP-GET       HTTP-GET
                \            |           /
                 +----------------------+
                 |      Prometheus      |
                 +----------------------+
```