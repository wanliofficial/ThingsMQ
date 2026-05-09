# 本地开发

## 本地构建

```bash
# 临时设置环境变量跳过所有插件加载
REBAR3_NO_PLUGINS=1 make emqx

# 或
SKIP_DEPS=1 make emqx
```

## 生成erlfmt escript

```bash
cd _build/default/plugins/erlfmt
rebar3 as release escriptize
cp _build/release/bin/erlfmt ../../../../scripts/erlfmt
```
