# 开发指南

## 本地构建

```bash
rebar3 get-deps # 先用本地rebar3获取依赖
make
```

## 打包发布
```bash
./build emqx zip # linux通用压缩包
./build emqx pkg # redhat .rpm包/debian .deb包
```