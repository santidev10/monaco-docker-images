# escape=`

FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

# Download channel for fixed install.
ARG CHANNEL_URL=https://aka.ms/vs/16/release/channel
ADD ${CHANNEL_URL} C:\TEMP\VisualStudio.chman

RUN `
    # Download the Build Tools bootstrapper.
    curl -SL --output vs_buildtools.exe https://aka.ms/vs/16/release/vs_buildtools.exe `
    `
    # Install Build Tools with the Microsoft.VisualStudio.Workload.AzureBuildTools workload, excluding workloads and components with known issues.
    && (start /w vs_buildtools.exe --quiet --wait --norestart --nocache `
        --installPath "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\BuildTools" `
        --channelUri C:\TEMP\VisualStudio.chman `
        --installChannelUri C:\TEMP\VisualStudio.chman `
        --add Microsoft.VisualStudio.Workload.VCTools --includeRecommended`
        --add Microsoft.VisualStudio.Component.VC.ATL `
        --add Microsoft.VisualStudio.Component.Windows10SDK.19041 `
        || IF "%ERRORLEVEL%"=="3010" EXIT 0) `
    `
    # Cleanup
    && del /q vs_buildtools.exe

# TODO Install Alablas-cli
ENTRYPOINT ["C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\BuildTools\\Common7\\Tools\\VsDevCmd.bat", "&&", "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]
