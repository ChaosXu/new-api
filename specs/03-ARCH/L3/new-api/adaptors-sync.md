# 渠道适配器（同步中继）

> **同构折叠组**：39 个同步渠道适配器，都实现 `relay/channel.Adaptor` 接口，结构同构，折叠汇总于此。各自独立职责见下表。

## 共性依赖（内部）

几乎所有适配器（≥34/39）都依赖以下模块：

- relay/channel
- relay/common
- relaykit/dto
- relaykit/types

## 各适配器特例（非共性依赖）

| 适配器 | 非共性依赖（共性之外） |
| --- | --- |
| relay/channel/advancedcustom | constant、relay/channel/claude、relay/channel/gemini、relay/channel/openai、relay/constant、relaykit/relayconvert、service |
| relay/channel/ai360 | （仅共性依赖） |
| relay/channel/ali | common、logger、relay/channel/claude、relay/channel/openai、relay/constant、service、setting/model_setting |
| relay/channel/aws | common、logger、relay/channel/claude、relay/helper、service、setting/model_setting |
| relay/channel/baidu | common、constant、relay/constant、relay/helper、service |
| relay/channel/baidu_v2 | relay/channel/openai、relay/constant |
| relay/channel/claude | common、constant、logger、relay/helper、relaykit/relayconvert、service、setting/model_setting |
| relay/channel/cloudflare | logger、relay/channel/openai、relay/constant、relay/helper、service |
| relay/channel/codex | common、relay/channel/openai、relay/constant、setting/ratio_setting |
| relay/channel/cohere | common、relay/constant、relay/helper、service |
| relay/channel/coze | common、relay/helper、service |
| relay/channel/deepseek | common、relay/channel/claude、relay/channel/openai、relay/constant、setting/reasoning |
| relay/channel/dify | common、constant、relay/helper、service |
| relay/channel/gemini | common、constant、logger、relay/channel/openai、relay/constant、relay/helper、relaykit/relayconvert、service、setting/model_setting、setting/reasoning |
| relay/channel/jimeng | logger、relay/channel/openai、relay/constant、service |
| relay/channel/jina | relay/channel/openai、relay/common_handler、relay/constant |
| relay/channel/lingyiwanwu | （仅共性依赖） |
| relay/channel/minimax | common、constant、relay/channel/claude、relay/channel/openai、relay/constant、service |
| relay/channel/mistral | common、relay/channel/openai |
| relay/channel/mokaai | common、relay/constant、service |
| relay/channel/moonshot | common、constant、relay/channel/claude、relay/channel/openai、relay/constant |
| relay/channel/newapi | relay/channel/claude、relay/channel/gemini、relay/channel/openai、relay/constant |
| relay/channel/ollama | common、constant、logger、relay/channel/openai、relay/constant、relay/helper、service |
| relay/channel/openai | common、constant、logger、relay/channel/ai360、relay/channel/lingyiwanwu、relay/channel/minimax、relay/channel/openrouter、relay/channel/xinference、relay/common_handler、relay/constant、relay/helper、relaykit/relayconvert、service、setting/model_setting、setting/reasoning |
| relay/channel/openrouter | （仅共性依赖） |
| relay/channel/palm | common、constant、relay/helper、service |
| relay/channel/perplexity | relay/channel/openai、relay/constant |
| relay/channel/replicate | common、constant、relay/constant、service |
| relay/channel/siliconflow | common、relay/channel/openai、relay/constant、service |
| relay/channel/sub2api | relay/channel/newapi |
| relay/channel/submodel | relay/channel/openai |
| relay/channel/tencent | common、constant、relay/channel/openai、relay/helper、service |
| relay/channel/vertex | common、relay/channel/claude、relay/channel/gemini、relay/channel/openai、relay/constant、service、setting/model_setting、setting/reasoning |
| relay/channel/volcengine | constant、relay/channel/claude、relay/channel/openai、relay/constant、setting/model_setting |
| relay/channel/xai | common、relay/channel/openai、relay/constant、relay/helper、service |
| relay/channel/xinference | （仅共性依赖） |
| relay/channel/xunfei | common、constant、relay/helper |
| relay/channel/zhipu | common、constant、relay/helper、service |
| relay/channel/zhipu_4v | common、constant、logger、relay/channel/claude、relay/channel/openai、relay/constant、service |
