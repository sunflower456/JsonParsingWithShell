https://github.com/influxdata/telegraf/blob/release-1.28/plugins/inputs/exec/README.md

---
vpa_pod_request,pod="frontend-5bdd9f855d-5npfr",resource="cpu" gauge=.35000000000000000000
vpa_pod_request,pod="frontend-5bdd9f855d-5npfr",resource="memory" gauge=1168723596
vpa_pod_request,pod="frontend-5bdd9f855d-v65n9",resource="cpu" gauge=.35000000000000000000
vpa_pod_request,pod="frontend-5bdd9f855d-v65n9",resource="memory" gauge=1168723596
vpa_target_info,vpa_name=frontend-vpa,resource=cpu,recommendation=lowerBound,unit=cores gauge=.02500000000000000000
vpa_target_info,vpa_name=frontend-vpa,resource=cpu,recommendation=target,unit=cores gauge=.35000000000000000000
vpa_target_info,vpa_name=frontend-vpa,resource=cpu,recommendation=uncappedTarget,unit=cores gauge=.35000000000000000000
vpa_target_info,vpa_name=frontend-vpa,resource=cpu,recommendation=upperBound,unit=cores gauge=.68000000000000000000
vpa_target_info,vpa_name=frontend-vpa,resource=memory,recommendation=upperBound,unit=bytes gauge=2056082131
vpa_target_info,vpa_name=frontend-vpa,resource=memory,recommendation=target,unit=bytes gauge=1168723596
vpa_target_info,vpa_name=frontend-vpa,resource=memory,recommendation=lowerBound,unit=bytes gauge=262144000
vpa_target_info,vpa_name=frontend-vpa,resource=memory,recommendation=uncappedTarget,unit=bytes gauge=1168723596

---
telegraf --config ./telegraf.conf

---
- VPA metric -> telegraf metric
- get from kubectl cmd line
- parsing with jq
