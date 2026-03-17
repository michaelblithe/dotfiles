export LLAMA_CPP_URL="http://house-of-wind:8001/v1"
list-models() {
  http $LLAMA_CPP_URL/models | jq -r '.data[]'.id
}
list-loaded-models() {
  http $LLAMA_CPP_URL/models | jq -r '.data[] | select(.status.value == "loaded")'.id
}
list-unloaded-models() {
  http $LLAMA_CPP_URL/models | jq -r '.data[] | select(.status.value == "unloaded")'.id
}
load-model() {
  local model=$1
  http POST $LLAMA_CPP_URL/models/load model="$model"
}
unload-model() {
  local model=$1
  http POST $LLAMA_CPP_URL/models/unload model="$model"
}
