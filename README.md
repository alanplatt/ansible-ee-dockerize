priority-dockerize
==================

Ansible role to build/run docker containers.

## Assumptions

- Control machine (.i.e where ansible run from. E.g. Jenkins) has access to 
  artifact on s3 via instance profile policy. Hence, no AWS creds is requested.

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
