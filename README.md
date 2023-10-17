# How to run
1. Build and setup WSL2 kenrel with Cilium support
```powershell
powershell -ExecutionPolicy Bypass -File ./build.ps1 -ImgDstDir "<path to image dst dir>"
```
2. Switch WSL2 to cgroups v2
On WSL shell add "cgroup2 /sys/fs/cgroup cgroup2 rw,nosuid,nodev,noexec,relatime,nsdelegate 0 0"
to /etc/fstab and reboot WSL2
```powershell
wsl --shutdown
```
