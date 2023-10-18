# How to run
1. Build and setup WSL2 kenrel with Cilium support
    ```powershell
    powershell -ExecutionPolicy Bypass -File ./build.ps1 -ImgDstDir "<path to image dst dir>"
    ```
2. Enable cgroups v2 on WSL2 by adding following line to /etc/fstab
    ```bash
    echo 'cgroup2 /sys/fs/cgroup cgroup2 rw,nosuid,nodev,noexec,relatime,nsdelegate 0 0' >> /etc/fstab
    ```
3. Reboot wsl
    ```powershell
    wsl --shutdown
    ```
