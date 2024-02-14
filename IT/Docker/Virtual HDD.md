# What it is

**Volume** - is a way to save some folders and use them as a real-time shared folders

# Run new container with a volume

```bash
#                                                                                  read and write. Another opption: 'ro' (read only)
docker run \
    container_name \
        --volume \
            /existing/folder/on/your/pc/or/saved/folder:\
            /new/folder/in/container:\
            rw # read and write
```

# Delete existing volume

`docker volumne rm volume_name`