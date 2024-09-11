library(plumber)

# 指定 API 文件的路徑
api <- plumb("scorad_api1.R")

# 運行 API
api$run(host="0.0.0.0", port=8000)

##cd /Users/ming/Downloads
##Rscript run_api.R

##curl -X POST "http://localhost:8000/predict" \
##-H "Content-Type: application/json" \
##-d '{"day": 50, "patient": "1", "extent": 6, "itching_vas": 1, "sleep_disturbance_vas": 3}'

