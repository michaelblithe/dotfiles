export LLAMA_CPP_URL="http://house-of-wind:8001"
list-models() {
  http $LLAMA_CPP_URL/v1/models | jq -r '.data[]'.id
}
list-loaded-models() {
  http $LLAMA_CPP_URL/v1/models | jq -r '.data[] | select(.status.value == "loaded")'.id
}
list-unloaded-models() {
  http $LLAMA_CPP_URL/v1/models | jq -r '.data[] | select(.status.value == "unloaded")'.id
}
load-model() {
  local model=$1
  http POST $LLAMA_CPP_URL/v1/models/load model="$model"
}
unload-model() {
  local model=$1
  http POST $LLAMA_CPP_URL/v1/models/unload model="$model"
}

claude-local() {
  local opus_model=$1
  local sonnet_model={$2:-$opus_model}
  local haiku_model={$3:-$sonnet_model}
  local code_subagent_model={$4:-$haiku_model}
  export ANTHROPIC_BASE_URL=$LLAMA_CPP_URL
  export ANTHROPIC_MODEL=$sonnet_model
  export ANTHROPIC_DEFAULT_OPUS_MODEL=$opus_model
  export ANTHROPIC_DEFAULT_SONNET_MODEL=$sonnet_model
  export ANTHROPIC_DEFAULT_HAIKU_MODEL=$haiku_model
  export CLAUDE_CODE_SUBAGENT_MODEL=$code_subagent_model
  export ENABLE_TOOL_SEARCH=false
  claude 
}