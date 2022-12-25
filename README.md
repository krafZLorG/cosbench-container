# How to use this image

```
docker pull ghcr.io/krafzlorg/cosbench:latest
```

## Start local driver and controller

```
docker run -d --net host --name cosbench ghcr.io/krafzlorg/cosbench:latest
```

## Start driver

```
docker run -d --net host --name cosbench-driver ghcr.io/krafzlorg/cosbench:latest driver
```

## Start controller

Prepare controller.conf
```
[controller]
drivers = 1
log_level = WARN
log_file = log/system.log
archive_dir = archive

[driver1]
name = driver1
url = http://127.0.0.1:18088/driver
```

```
mkdir -p /opt/cosbench/{archive,log}

docker run -d --net host --name cosbench-controller \
  -v /opt/cosbench/archive:/cosbench/archive \
  -v /opt/cosbench/log:/cosbench/log \
  -v /opt/cosbench/controller.conf:/cosbench/conf/controller.conf:ro \
ghcr.io/krafzlorg/cosbench:latest controller
```
