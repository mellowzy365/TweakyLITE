Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

# ==============================
# AUTO ELEVATE ADMIN
# ==============================
$currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($currentUser)

if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# ==========================
# XAML GUI
# ==========================
$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="TweakyLITE v1.02"
        Height="640"
        Width="800"
        WindowStartupLocation="CenterScreen"
        Background="#8da9c2">

    <Window.Resources>
        <Style TargetType="Button">
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="Background" Value="#2A2A2A"/>
            <Setter Property="BorderBrush" Value="#3A3A3A"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Height" Value="40"/>
            <Setter Property="FontSize" Value="16"/>
            <Setter Property="Margin" Value="5"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border x:Name="border"
                                Background="{TemplateBinding Background}"
                                BorderBrush="{TemplateBinding BorderBrush}"
                                BorderThickness="1"
                                CornerRadius="8">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter TargetName="border" Property="Background" Value="#00C8FF"/>
                                <Setter Property="Foreground" Value="Black"/>
                            </Trigger>
                            <Trigger Property="IsPressed" Value="True">
                                <Setter TargetName="border" Property="Background" Value="#0099CC"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="*"/>
            <RowDefinition Height="35"/>
        </Grid.RowDefinitions>

        <TabControl Grid.Row="0" Margin="10">
        <TabItem Header="System Information">
    <StackPanel Margin="25">
        
        <TextBlock Text="System Information"
                   FontSize="20"
                   FontWeight="Bold"
                   Foreground="#00C8FF"
                   Margin="0,0,0,15"/>

        <TextBlock Name="txtWinVersion"
                   FontWeight="Bold"
                   Margin="0,5,0,5"/>

        <TextBlock Name="txtSecureBoot"
                   FontWeight="Bold"
                   Margin="0,5,0,5"/>

        <TextBlock Name="txtTPM"
                   FontWeight="Bold"
                   Margin="0,5,0,5"/>

    </StackPanel>
</TabItem>
            <!-- Tab Tweak -->
            <TabItem Header="Tweak">
                <StackPanel Margin="20">
                <TextBlock Text="Tweak" FontSize="20" FontWeight="Bold" Foreground="#00C8FF" Margin="0,0,0,15"/>

                    <Button Name="btnTelemetry" Content="Disable Telemetry"/>
                    <Button Name="btnBgSync" Content="Disable Background Sync"/>
                    <Button Name="btnAI" Content="Disable Microsoft AI"/>
                    <Button Name="btnGameBar" Content="Disable Game Bar"/>
                    <Button Name="btnRSS" Content="Disable RSS + Lowest Latency"/>
                    <Button Name="btnSuperfetch" Content="Disable SuperFetch"/>
                    <Button Name="btnWU" Content="Disable Windows Update"/>
                    <Button Name="btnErrorReport" Content="Disable Error Reporting"/>
                </StackPanel>
            </TabItem>

            <!-- Tab Clean Up -->
            <TabItem Header="Clean Up">
                <StackPanel Margin="20">
                <TextBlock Text="Clean Up" FontSize="20" FontWeight="Bold" Foreground="#00C8FF" Margin="0,0,0,15"/>
                    <Button Name="btnTemp" Content="Clean Cache &amp; Temporary Files"/>
                    <Button Name="btnReserved" Content="Disable Reserved Storage"/>
                    <Button Name="btnNvidia" Content="Remove NVIDIA Telemetry"/>
                </StackPanel>
            </TabItem>

            <TabItem Header="Network">
    <StackPanel Margin="25">
        <TextBlock Text="DNS Information" FontSize="20" FontWeight="Bold" Foreground="#00C8FF" Margin="0,0,0,15"/>
        
        <!-- List DNS -->
        <TextBlock Text="Current IPv4 DNS Servers:" FontWeight="Bold" Margin="0,0,0,5"/>
        <TextBlock Name="txtDNS1" Margin="0,0,0,2"/>
        <TextBlock Name="txtDNS2" Margin="0,0,0,10"/>

        <!-- Custom DNS Input -->
        <TextBlock Text="Custom DNS (IPv4)" FontWeight="Bold"/>

<TextBox Name="txtPrimaryDNS"
         Width="200"
         Margin="0,5,0,5" />

<TextBox Name="txtSecondaryDNS"
         Width="200"
         Margin="0,5,0,15" />

        <!-- Buttons -->
        <StackPanel Orientation="Horizontal" HorizontalAlignment="Left" >
            <Button Name="btnSetDNS" Content="Set Custom DNS" Width="150" Margin="0,0,10,0"/>
            <Button Name="btnFlushDNS" Content="Flush DNS" Width="100" Margin="0,0,10,0"/>
            <Button Name="btnOpenNetConn" Content="Open Network Connections" Width="240"/>
        </StackPanel>
    </StackPanel>
</TabItem>

            <!-- Tab Power Option -->
            <TabItem Header="Power Options">
                <StackPanel Margin="20">
                <TextBlock Text="Power Options" FontSize="20" FontWeight="Bold" Foreground="#00C8FF" Margin="0,0,0,15"/>
                    <Button Name="btnPerf" Content="Performance Profile"/>
                    <Button Name="btnBalance" Content="Balanced Profile"/>
                </StackPanel>
            </TabItem>

            <!-- Tab Restore Point -->
            <TabItem Header="Restore Point">
                <StackPanel Margin="20">
                <TextBlock Text="Restore Point" FontSize="20" FontWeight="Bold" Foreground="#00C8FF" Margin="0,0,0,15"/>
                    <Button Name="btnRestore" Content="Open Restore Point"/>
                </StackPanel>
            </TabItem>

            <TabItem Header="Restart PC">
    <StackPanel Margin="20">
    <TextBlock Text="Restart Computer" FontSize="20" FontWeight="Bold" Foreground="#00C8FF" Margin="0,0,0,15"/>
        <Button Name="btnRestart" Content="Restart After Apply Tweaks"/>
    </StackPanel>
</TabItem>

            <TabItem Header="Game Tweaks">
    <StackPanel Margin="25">

        <TextBlock Text="Game Tweaks"
                   FontSize="20"
                   FontWeight="Bold"
                   Foreground="#00C8FF"
                   Margin="0,0,0,20"/>

        <Button Name="btnWW"
                Content="Wuthering Waves"
                Height="40"/>

        <Button Name="btnEndfield"
                Content="Arknights Endfield"
                Height="40"/>

        <Button Name="btnCS2"
                Content="Counter-Strike 2"
                Height="40"/>

        <Button Name="btnZZZ"
                Content="Zenless Zone Zero"
                Height="40"/>

        <TextBlock Name="txtGameTweakStatus"
                   Text="Status: Idle"
                   Foreground="Black"
                   Margin="0,20,0,0"
                   FontWeight="Bold"/>

    </StackPanel>
</TabItem>

            <!-- Tab About -->
            <TabItem Header="About">
                <StackPanel Margin="30" HorizontalAlignment="Center">
                    <TextBlock Text="TweakyLITE" FontSize="28" FontWeight="Bold" Foreground="#00C8FF" Margin="0,0,0,5"/>
                    <TextBlock Text="Version 1.02" Margin="0,5,0,5" FontWeight="Bold" Foreground="Black"/>
                    <TextBlock Text="Author : Mellowzy" Margin="0,5,0,5" FontWeight="Bold" Foreground="Black"/>
                    
                    <Button Name="btnGitHub" Content="Visit GitHub Repository" Width="250"/>
                    <Button Name="btnSaweria" Content="Support for Development" Width="250" Margin="0,10,0,0"/>

                    <TextBlock Name="txtChangelog"
           Text="View Changelog"
           FontSize="13"
           Foreground="#0078D7"
           TextDecorations="Underline"
           Cursor="Hand"
           Margin="0,10,0,10"
           HorizontalAlignment="Center"
           TextAlignment="Center"/>

                </StackPanel>
            </TabItem>

        </TabControl>

        <ProgressBar Name="progressBar" Grid.Row="1" Margin="10" Height="18" Minimum="0" Maximum="100"/>
    </Grid>
</Window>
"@

# ==========================
# Load XAML & Bind Controls
# ==========================
$reader = New-Object System.Xml.XmlNodeReader ([xml]$xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

# Auto-bind named controls
([xml]$xaml).SelectNodes("//*[@Name]") | ForEach-Object {
    Set-Variable -Name $_.Name -Value $window.FindName($_.Name)
}

# Ambil TextBlock About Tab secara langsung
$txtWinVersion = $window.FindName("txtWinVersion")

$txtSecureBoot = $window.FindName("txtSecureBoot")
$txtTPM        = $window.FindName("txtTPM")

$txtSecureBoot.Text = "Secure Boot: $secureBootStatus"
$txtTPM.Text        = "TPM State: $tpmStatus"

# ==========================
# System Monitoring Detection
# ==========================
# Ambil DNS aktif
$dnsServers = Get-DnsClientServerAddress -AddressFamily IPv4 |
    Where-Object { $_.ServerAddresses } |
    Select-Object -ExpandProperty ServerAddresses

$dns1 = if ($dnsServers.Count -ge 1) { $dnsServers[0] } else { "Not Set" }
$dns2 = if ($dnsServers.Count -ge 2) { $dnsServers[1] } else { "Not Set" }

# Assign ke TextBlock
$txtDNS1 = $window.FindName("txtDNS1")
$txtDNS2 = $window.FindName("txtDNS2")
$txtDNS1.Text = "Primary DNS  : $dns1"
$txtDNS2.Text = "Secondary DNS: $dns2"

# Windows Version
try {
    $os = Get-CimInstance Win32_OperatingSystem
    $build = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").CurrentBuild
    $winVersion = "$($os.Caption) Build $build"
}
catch {
    $winVersion = "Unknown Windows Version"
}

# Secure Boot
try {
    if ([Environment]::Is64BitOperatingSystem) {
        $sb = Confirm-SecureBootUEFI -ErrorAction Stop
        $secureBootStatus = if ($sb) { "Enabled" } else { "Disabled" }
    } else {
        $secureBootStatus = "Unsupported (32-bit)"
    }
}
catch {
    $secureBootStatus = "Not Supported / Legacy BIOS"
}

# TPM
try {
    $tpm = Get-WmiObject -Namespace "root\CIMV2\Security\MicrosoftTpm" `
                         -Class Win32_Tpm -ErrorAction Stop

    if ($tpm.IsEnabled().IsEnabled) {
        $tpmStatus = "Enabled"
    } else {
        $tpmStatus = "Present but Disabled"
    }
}
catch {
    $tpmStatus = "Not Present / Unsupported"
}

# Assign to UI
$window.FindName("txtWinVersion").Text  = "Windows Version : $winVersion"
$window.FindName("txtSecureBoot").Text  = "Secure Boot     : $secureBootStatus"
$window.FindName("txtTPM").Text         = "TPM State       : $tpmStatus"

# ==========================
# Secure Boot Detection (Stable)
# ==========================
try {
    if ([Environment]::Is64BitOperatingSystem) {
        $sb = Confirm-SecureBootUEFI -ErrorAction Stop
        $secureBootStatus = if ($sb) { "Enabled" } else { "Disabled" }
    } else {
        $secureBootStatus = "Unsupported (32-bit PS)"
    }
}
catch {
    $secureBootStatus = "Not Supported / Legacy BIOS"
}

# ==========================
# TPM Detection (Stable)
# ==========================
try {
    $tpm = Get-WmiObject -Namespace "root\CIMV2\Security\MicrosoftTpm" `
                         -Class Win32_Tpm -ErrorAction Stop

    if ($tpm) {
        if ($tpm.IsEnabled().IsEnabled) {
            $tpmStatus = "Enabled"
        } else {
            $tpmStatus = "Present but Disabled"
        }
    }
}
catch {
    $tpmStatus = "Not Present / Unsupported"
}

if (-not $tpmStatus) { $tpmStatus = "Not Detected" }

# ==========================
# Assign to About Tab
# ==========================
$txtSecureBoot = $window.FindName("txtSecureBoot")
$txtTPM        = $window.FindName("txtTPM")

if ($txtSecureBoot) { $txtSecureBoot.Text = "Secure Boot: $secureBootStatus" }
if ($txtTPM)        { $txtTPM.Text        = "TPM State: $tpmStatus" }

# ==========================
# Detection Status
# ==========================
# Detect Windows Version
try {
    $os = Get-CimInstance Win32_OperatingSystem
    $build = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").CurrentBuild
    $caption = $os.Caption
    $winVersion = "$caption Build $build"
} catch {
    $winVersion = "Unknown Windows Version"
}

# Set text ke TextBlock About Tab
if ($txtWinVersion -ne $null) {
    $txtWinVersion.Text = "Windows Version : $winVersion"
} else {
    [System.Windows.Forms.MessageBox]::Show("TextBlock txtWinVersion noy found!")
}

# ==========================
# Progress Bar Function
# ==========================
function Show-Progress {
    $progressBar.Value = 0
    1..100 | ForEach-Object {
        $progressBar.Value = $_
        Start-Sleep -Milliseconds 5
    }
}

# ==========================
# Tweaking / System Functions
# ==========================
function Safe-Debloat {
    Stop-Service DiagTrack -ErrorAction SilentlyContinue
    Set-Service DiagTrack -StartupType Disabled
    [System.Windows.Forms.MessageBox]::Show("Telemetry disabled successfully.","Success")
}

function Disable-BackgroundSync {
    try {
        New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Force | Out-Null
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name "GlobalUserDisabled" -Value 1 -Force
        [System.Windows.Forms.MessageBox]::Show("Background Sync & Apps disabled.","Success")
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Gagal menonaktifkan Background Sync.","Error")
    }
}

function Disable-MicrosoftAI {
    try {
        if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
        }
        if (-not (Test-Path "HKCU:\Software\Policies\Microsoft\AI")) {
            New-Item -Path "HKCU:\Software\Policies\Microsoft\AI" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Type DWord -Value 0 -Force
        Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\AI" -Name "EnableAI" -Type DWord -Value 0 -Force
        [System.Windows.Forms.MessageBox]::Show("Microsoft AI features disabled (partial).","Success")
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Gagal menonaktifkan Microsoft AI.","Error")
    }
}

function Disable-GameBar {
    try {
        New-Item -Path "HKCU:\Software\Microsoft\GameBar" -Force | Out-Null
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "AllowAutoGameMode" -Value 0 -Force
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "ShowStartupPanel" -Value 0 -Force
        [System.Windows.Forms.MessageBox]::Show("Game Bar disabled.","Success")
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Gagal menonaktifkan Game Bar.","Error")
    }
}

function Disable-RSS {
    try {
        netsh int tcp set global rss=disabled | Out-Null
        netsh int tcp set global autotuninglevel=disabled | Out-Null
        netsh int tcp set global chimney=disabled | Out-Null
        [System.Windows.Forms.MessageBox]::Show("RSS & low latency applied.","Success")
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Gagal menonaktifkan RSS.","Error")
    }
}

function Disable-Superfetch {
    Stop-Service SysMain -ErrorAction SilentlyContinue
    Set-Service SysMain -StartupType Disabled
    [System.Windows.Forms.MessageBox]::Show("Superfetch (SysMain) disabled.","Success")
}

function Disable-WU {
    Stop-Service wuauserv -ErrorAction SilentlyContinue
    Set-Service wuauserv -StartupType Disabled
    [System.Windows.Forms.MessageBox]::Show("Windows Update disabled.","Success")
}

function Flush-DNS {
    ipconfig /flushdns | Out-Null
    [System.Windows.Forms.MessageBox]::Show("DNS cache flushed.","Success")
}

function Clean-Temp {
    Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "%localappdata%\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    [System.Windows.Forms.MessageBox]::Show("Temporary files cleaned.","Success")
}

function Disable-ReservedStorage {
    try {
        reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" /v ShippedWithReserves /t REG_DWORD /d 0 /f | Out-Null
        [System.Windows.Forms.MessageBox]::Show("Reserved Storage disabled (partial).","Success")
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Gagal menonaktifkan Reserved Storage.","Error")
    }
}

function Remove-NvidiaTelemetry {
    try {
        Stop-Service "NvTelemetryContainer" -ErrorAction SilentlyContinue
        Set-Service "NvTelemetryContainer" -StartupType Disabled -ErrorAction SilentlyContinue
        [System.Windows.Forms.MessageBox]::Show("NVIDIA Telemetry disabled.","Success")
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Gagal menonaktifkan NVIDIA Telemetry.","Error")
    }
}

function Performance-Boost {
    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null
    powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61
    [System.Windows.Forms.MessageBox]::Show("Performance profile activated.","Success")
}

function Balance-Power {
    powercfg /setactive SCHEME_BALANCED
    [System.Windows.Forms.MessageBox]::Show("Balanced profile activated.","Success")
}

function Restart-PC {
    try {
        Restart-Computer -Force
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Gagal me-restart PC.","Error")
    }
}

function Disable-ErrorReporting {
    try {
        # Stop & Disable Service
        Stop-Service WerSvc -ErrorAction SilentlyContinue
        Set-Service WerSvc -StartupType Disabled -ErrorAction SilentlyContinue

        # Disable via Registry (Policy)
        if (-not (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Force | Out-Null
        }

        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" `
                         -Name "Disabled" -Type DWord -Value 1 -Force

        [System.Windows.Forms.MessageBox]::Show("Windows Error Reporting disabled.","Success")
    }
    catch {
        [System.Windows.Forms.MessageBox]::Show("Gagal menonaktifkan Error Reporting.","Error")
    }
}

# Set Custom DNS
function Set-CustomDNS {
    param($Primary,$Secondary)

    try {
        $nic = Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | Select-Object -First 1

        if ($nic) {

            if ($Primary -and $Secondary) {
                Set-DnsClientServerAddress -InterfaceAlias $nic.Name -ServerAddresses @($Primary,$Secondary)
            }
            elseif ($Primary) {
                Set-DnsClientServerAddress -InterfaceAlias $nic.Name -ServerAddresses $Primary
            }
            else {
                [System.Windows.Forms.MessageBox]::Show("Masukkan minimal Primary DNS.","Error")
                return
            }

            [System.Windows.Forms.MessageBox]::Show("DNS berhasil diterapkan.","Success")

            # Refresh tampilan DNS
            $dnsServers = Get-DnsClientServerAddress -InterfaceAlias $nic.Name -AddressFamily IPv4

            $txtDNS1.Text = "Primary DNS  : " + ($dnsServers.ServerAddresses[0])

            if ($dnsServers.ServerAddresses.Count -ge 2) {
                $txtDNS2.Text = "Secondary DNS: " + ($dnsServers.ServerAddresses[1])
            }
            else {
                $txtDNS2.Text = "Secondary DNS: Not Set"
            }
        }
    }
    catch {
        [System.Windows.Forms.MessageBox]::Show("Gagal set DNS. Pastikan format IPv4 valid & jalankan sebagai Admin.","Error")
    }
}

# Flush DNS
function Flush-DNSUI {
    ipconfig /flushdns | Out-Null
    [System.Windows.Forms.MessageBox]::Show("DNS cache flushed.","Success")
}

# Open Network Connections
function Open-NetworkConnections {
    Start-Process "ncpa.cpl"
}

# ==========================
# Restore Point
# ==========================
function Open-RestorePointWindow {
    try {
        Start-Process "SystemPropertiesProtection.exe"
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Gagal membuka jendela Restore Point.","Error")
    }
}

# ==========================
# Game Tweak Monitor System
# ==========================

$global:GameMonitorTimer = $null
$global:TargetProcessName = $null
$global:BoostedPID = $null

function Start-GameTweak {
    param($processName)

    # Stop monitor lama kalau ada
    if ($global:GameMonitorTimer) {
        $global:GameMonitorTimer.Stop()
        $global:GameMonitorTimer = $null
    }

    $global:TargetProcessName = $processName
    $global:BoostedPID = $null

    $txtGameTweakStatus.Text = "Status: Waiting for $processName..."

    $timer = New-Object System.Windows.Threading.DispatcherTimer
    $timer.Interval = [TimeSpan]::FromSeconds(2)

    $timer.Add_Tick({

        try {
            $proc = Get-Process -Name $global:TargetProcessName -ErrorAction SilentlyContinue | Select-Object -First 1

            # Kalau game ditemukan pertama kali
            if ($proc -and -not $global:BoostedPID) {

                $proc.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::High
                $global:BoostedPID = $proc.Id

                $txtGameTweakStatus.Text = "Status: $($proc.ProcessName) detected → Priority HIGH"
            }

            # Kalau game ditutup
            elseif (-not $proc -and $global:BoostedPID) {

                $txtGameTweakStatus.Text = "Status: Game closed → Monitoring stopped"

                $timer.Stop()
                $global:BoostedPID = $null
            }
        }
        catch {
            # silent error
        }
    })

    $timer.Start()
    $global:GameMonitorTimer = $timer
}

# ==========================
# Event Handlers
# ==========================
$btnTelemetry.Add_Click({ Show-Progress; Safe-Debloat })
$btnBgSync.Add_Click({ Show-Progress; Disable-BackgroundSync })
$btnAI.Add_Click({ Show-Progress; Disable-MicrosoftAI })
$btnGameBar.Add_Click({ Show-Progress; Disable-GameBar })
$btnRSS.Add_Click({ Show-Progress; Disable-RSS })
$btnSuperfetch.Add_Click({ Show-Progress; Disable-Superfetch })
$btnWU.Add_Click({ Show-Progress; Disable-WU })

$btnTemp.Add_Click({ Show-Progress; Clean-Temp })
$btnReserved.Add_Click({ Show-Progress; Disable-ReservedStorage })
$btnNvidia.Add_Click({ Show-Progress; Remove-NvidiaTelemetry })

$btnPerf.Add_Click({ Show-Progress; Performance-Boost })
$btnBalance.Add_Click({ Show-Progress; Balance-Power })

$btnRestore.Add_Click({ Open-RestorePointWindow })

$btnRestart.Add_Click({ Show-Progress; Restart-PC })
$btnErrorReport.Add_Click({ Show-Progress; Disable-ErrorReporting })

$btnGitHub.Add_Click({ Start-Process "https://github.com/mellowzy365/TweakyLITE" })
$btnSaweria.Add_Click({ Start-Process "https://saweria.co/mellowzy" })
$btnSetDNS.Add_Click({
    Show-Progress
    Set-CustomDNS $txtPrimaryDNS.Text $txtSecondaryDNS.Text
})

$btnFlushDNS.Add_Click({ Show-Progress; Flush-DNSUI })
$btnOpenNetConn.Add_Click({ Open-NetworkConnections })

# ==========================
# Changelogs
# ==========================
$txtChangelog.Add_MouseLeftButtonUp({

    $changelogWindow = New-Object System.Windows.Window
    $changelogWindow.Title = "Changelog - TweakyLITE"
    $changelogWindow.Width = 400
    $changelogWindow.Height = 300
    $changelogWindow.WindowStartupLocation = "CenterScreen"
    $changelogWindow.ResizeMode = "NoResize"

    $stack = New-Object System.Windows.Controls.StackPanel
    $stack.Margin = "20"

    $title = New-Object System.Windows.Controls.TextBlock
    $title.Text = "Changelog"
    $title.FontSize = 18
    $title.FontWeight = "Bold"
    $title.Margin = "0,0,0,15"

    $content = New-Object System.Windows.Controls.TextBlock
    $content.Text = @"
v1.02
• Bug fixes
• Added Game Tweaks

v1.00
• Initial Release
• Fix Perfomance for Windows 11
"@
    $content.TextWrapping = "Wrap"

    $stack.Children.Add($title)
    $stack.Children.Add($content)

    $changelogWindow.Content = $stack
    $changelogWindow.ShowDialog()

})

# ==========================
# Game Tweak Buttons
# ==========================

$btnWW.Add_Click({
    Start-GameTweak "Client-Win64-Shipping"
})

$btnEndfield.Add_Click({
    Start-GameTweak "Endfield"
})

$btnCS2.Add_Click({
    Start-GameTweak "cs2"
})

$btnZZZ.Add_Click({
    Start-GameTweak "ZenlessZoneZero"
})

# ==========================
# Add ToolTips Automatically
# ==========================
$tooltipMap = @{
    btnTelemetry = "Telemetry service track and log usage sending feedback data for analysis to Microsoft"
    btnBgSync    = "Turn off background synchronization apps for free up RAM"
    btnAI       = "Disable Microsoft AI features"
    btnGameBar  = "Turn off Game Bar & Xbox overlay"
    btnRSS      = "Disable RSS & set low latency TCP"
    btnSuperfetch = "Disable SysMain service (Superfetch)"
    btnWU       = "Stop and disable Windows Update service"
    btnFlushDNS      = "Flush DNS cache"
    btnTemp     = "Clean temporary files from Windows and user folders"
    btnReserved = "Disable Reserved Storage partially (Windows Update must disable first!)"
    btnNvidia   = "Stop and disable NVIDIA telemetry services"
    btnPerf     = "Activate high performance power profile"
    btnBalance  = "Activate balanced power profile"
    btnRestore  = "Open Restore Point management window"
    btnErrorReport = "Error reporting collects application crashes and errors and send them to Microsoft"
    btnOpenNetConn = "Open Network Connection Window"
    btnSetDNS = "set custom DNS"
}

foreach ($btnName in $tooltipMap.Keys) {
    $btn = Get-Variable -Name $btnName -ErrorAction SilentlyContinue
    if ($btn) {
        $btn.Value.ToolTip = $tooltipMap[$btnName]
    }
}

# ==========================
# Show Window
# ==========================
$window.ShowDialog() | Out-Null
