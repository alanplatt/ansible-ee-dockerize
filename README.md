priority-dockerize
==================

Ansible role to build/run docker containers.

Supported sources of artifacts:
- local filesystem (full path of file)
- s3

## Assumptions

- AWS S3 used for app artificat repository
- Instance profile configured to allow download (GET) of artifact

## Example

To build image and run container from image built

```
  vars:
    dockerize_task:        'build:run'
    dockerize_app_name:    "myapp"
    dockerize_app_version: 17
    dockerize_app_conf_file: /var/tmp/dockerize/myapp/config/app.yml
    dockerize_artifact_s3_bucket: microdc-infra
    dockerize_artifact_s3_object: /artifacts/{{ dockerize_app_name }}-{{ dockerize_app_version }}.tar.gz

  roles:
    - priority-dockerize
```

Note:
Valid values for `dockerize\_task` variable are:
- `build` - build image only
- `build:run` - build image and run container of image built
- `run` - run container only (of an existing image)


## Testing

```
kitchen test
```
