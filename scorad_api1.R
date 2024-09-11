library(brms)
library(dplyr)

# 載入已訓練的模型
model <- readRDS("scorad_model.rds")

#* @apiTitle SCORAD Prediction API

#* Predict SCORAD value
#* @param day Day of prediction
#* @param patient Patient ID
#* @param extent Extent value
#* @param itching_vas Itching VAS value
#* @param sleep_disturbance_vas Sleep disturbance VAS value
#* @post /predict
function(day, patient, extent, itching_vas, sleep_disturbance_vas) {
  # 創建新數據
  new_data <- data.frame(
    Day = as.numeric(day),
    Patient = as.factor(patient),
    Extent = as.numeric(extent),
    Itching.VAS = as.numeric(itching_vas),
    Sleep.disturbance.VAS = as.numeric(sleep_disturbance_vas)
  )
  
  # 進行預測，允許新的患者級別
  predictions <- predict(model, newdata = new_data, allow_new_levels = TRUE)
  
  # 返回結果
  list(
    predicted_SCORAD = predictions[, "Estimate"],
    lower_95 = predictions[, "Q2.5"],
    upper_95 = predictions[, "Q97.5"]
  )
}