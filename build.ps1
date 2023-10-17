function Create-WSLImage {
    param (
        [string]$wslImageDst
    )

    $wslConfigParentDir = (Split-Path -Path $wslImageDst)
    docker build -t wsl2 .
    docker create --name wsl2 wsl2
    New-Item -ItemType Directory -Path $wslConfigParentDir -Force
    docker cp wsl2:/WSL2-Linux-Kernel/arch/x86/boot/bzImage $wslImageDst
    docker rm wsl2
}

function Update-WSLConfig {
    param (
        [string]$wslImageDst
    )

    $wslConfigPath = [System.IO.Path]::Combine($env:USERPROFILE, ".wslconfig")
    $wslKernelPath = [System.IO.Path]::Combine($wslImageDst, "bzImage")
    "[wsl2]" | Set-Content -Path $wslConfigPath -Force
    "kernel=" + $wslImageDst.Replace('\', '\\') | Add-Content -Path $wslConfigPath
    "kernelCommandLine=cgroup_no_v1=all" | Add-Content -Path $wslConfigPath
}

function Main {
    param (
        [string]$wslImageDst
    )

    $wslImageDst = Join-Path $wslImageDst "wsl_image"
    Create-WSLImage $wslImageDst
    Update-WSLConfig $wslImageDst
}

param (
    [string]$ImgDstDir,
)

Main $ImgDstDir

# cgroup2 /sys/fs/cgroup cgroup2 rw,nosuid,nodev,noexec,relatime,nsdelegate 0 0
# /etc/fstab