# How to use this image

## Start local driver and controller

```
podman run -d --net host --name cosbench cosbench
```

## Start driver

```
podman run -d --net host --name cosbench-driver localhost/cosbench driver
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
podman run -d --net host --name cosbench-controller \
  -v ./archive:/cosbench/archive \
  -v ./log:/cosbench/log \
  -v ./controller.conf:/cosbench/conf/controller.conf:ro \
localhost/cosbench controller
```

