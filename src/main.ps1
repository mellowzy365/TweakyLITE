# ==========================
# TweakyLITE v1.04
# ==========================
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Windows.Forms

# ==========================
# Auto Elevate Admin
# ==========================
$currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($currentUser)

if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$splashXAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        Title="TweakyLITE Loading..."
        WindowStyle="None"
        ResizeMode="NoResize"
        Width="400" Height="200"
        WindowStartupLocation="CenterScreen"
        Background="#2A2A2A"
        AllowsTransparency="True">
    <Grid>
        <TextBlock Text="Loading please wait..."
                   HorizontalAlignment="Center"
                   VerticalAlignment="Center"
                   Foreground="White"
                   FontSize="20"
                   FontWeight="Bold"/>
    </Grid>
</Window>
"@

# ==========================
# Load & Show Splash Window
# ==========================
Add-Type -AssemblyName PresentationFramework
$readerSplash = New-Object System.Xml.XmlNodeReader ([xml]$splashXAML)
$splashWindow = [Windows.Markup.XamlReader]::Load($readerSplash)
$splashWindow.Show()


# ==========================
# Optional delay atau load resources
# ==========================
Start-Sleep -Milliseconds 3000  # Splash muncul 1.5 detik (ubah sesuai kebutuhan)

# ==========================
# XAML
# ==========================
$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="TweakyLITE v1.04"
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
        <TabItem Header="Home">
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
        <TextBlock Name="txtUser" FontWeight="Bold" Margin="0,5,0,5"/>
        <TextBlock Name="txtCPU" FontWeight="Bold" Margin="0,5,0,5"/>
        <TextBlock Name="txtRAM" FontWeight="Bold" Margin="0,5,0,5"/>
        <TextBlock Name="txtGPU" FontWeight="Bold" Margin="0,5,0,5"/>
        <TextBlock Name="txtBit" FontWeight="Bold" Margin="0,5,0,5"/>
        <TextBlock Name="txtSSD" FontWeight="Bold" Margin="0,5,0,5"/>

    </StackPanel>
</TabItem>
            <!-- Tab Tweak -->
            <TabItem Header="Tweak">
                <StackPanel Margin="20">
                <TextBlock Text="Tweak" FontSize="20" FontWeight="Bold" Foreground="#00C8FF" Margin="0,0,0,15"/>

                    <Button Name="btnTelemetry" Content="Disable Telemetry"/>
                    <Button Name="btnBgSync" Content="Disable Background Sync"/>
                    <Button Name="btnGameBar" Content="Disable Game Bar"/>
                    <Button Name="btnRSS" Content="Disable RSS + Lowest Latency"/>
                    <Button Name="btnSuperfetch" Content="Disable SuperFetch"/>
                    <Button Name="btnWU" Content="Disable Windows Update"/>
                    <Button Name="btnErrorReport" Content="Disable Error Reporting"/>

                </StackPanel>
            </TabItem>

            <!-- Tab Ai Manager -->
            <TabItem Header="Ai Manager">
                <StackPanel Margin="20">
                <TextBlock Text="Ai Manager" FontSize="20" FontWeight="Bold" Foreground="#00C8FF" Margin="0,0,0,15"/>
                    <Button Name="btnAI" Content="Disable Microsoft AI"/>
                    <Button Name="btnCopilotToggle" Margin="0,5,0,5"/>
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
        <TextBlock Text="Change DNS IPv4" FontSize="20" FontWeight="Bold" Foreground="#00C8FF" Margin="0,0,0,15"/>

        <TextBlock Text="Select Network Adapter"
           FontWeight="Bold"
           Margin="0,0,0,5"/>

           

<ComboBox Name="cmbAdapterList"
          Width="300"
          Height="30"
          Margin="0,0,0,15"/>
        
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

<StackPanel Margin="0,15,0,0">

    <TextBlock Text="DNS Preset"
               FontWeight="Bold"
               Margin="0,0,0,5"/>

    <ComboBox x:Name="cmbDNSPreset"
              Width="200"
              Height="30">
        <ComboBoxItem Content="Automatic (DHCP)" />
        <ComboBoxItem Content="AdGuard" />
        <ComboBoxItem Content="Cloudflare" />
        <ComboBoxItem Content="Google DNS" />
        <ComboBoxItem Content="OpenDNS" />
        <ComboBoxItem Content="Quad9" />
    </ComboBox>

</StackPanel>

        <!-- Buttons -->
        <TextBlock Text="Actions"
               FontWeight="Bold"
               Margin="0,0,0,5"/>
        <StackPanel Orientation="Horizontal" HorizontalAlignment="Left" >
            <Button Name="btnSetDNS" Content="Set Custom DNS" Width="150" Margin="0,0,10,0"/>
            <Button Name="btnFlushDNS" Content="Flush DNS" Width="100" Margin="0,0,10,0"/>
            <Button Name="btnOpenNetConn" Content="Open Network Connections" Width="240"/>
        </StackPanel>
    </StackPanel>
</TabItem>

            <!-- Tab Restore Point -->
            <TabItem Header="Restore Point">
                <StackPanel Margin="20">
                <TextBlock Text="Restore Point" FontSize="20" FontWeight="Bold" Foreground="#00C8FF" Margin="0,0,0,15"/>
                    <Button Name="btnRestore" Content="Open Restore Point"/>
                </StackPanel>
            </TabItem>

            <TabItem Header="Game Tweaks">
    <StackPanel Margin="25">
     <TextBlock Text="Game Tweaks" FontSize="20" FontWeight="Bold" Foreground="#00C8FF" Margin="0,0,0,15"/>
        <TextBlock Text="Select Game"
           FontSize="16"
           FontWeight="Bold"
           Margin="0,0,0,10"/>

<ComboBox Name="cmbGameList"
          Width="250"
          Height="30"
          Margin="0,0,0,10"/>

<Button Name="btnApplyGameTweak"
        Content="Apply Game Tweak"
        Width="220"
        Margin="0,5,0,5"/>

<TextBlock Name="txtGameStatus"
           Margin="0,10,0,0"
           FontWeight="Bold"/>

    </StackPanel>
</TabItem>

            <!-- Tab About -->
            <TabItem Header="About">
                <StackPanel Margin="30" HorizontalAlignment="Center">
                    <TextBlock Text="TweakyLITE" FontSize="28" FontWeight="Bold" Foreground="#00C8FF" Margin="0,0,0,5"/>
                    <TextBlock Text="Version 1.04" Margin="0,5,0,5" FontWeight="Bold" Foreground="Black"/>
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

        
    </Grid>
</Window>
"@

# ==========================
# KLoad XAML & Bind Controls
# ==========================
$reader = New-Object System.Xml.XmlNodeReader ([xml]$xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

# Auto-bind named controls
([xml]$xaml).SelectNodes("//*[@Name]") | ForEach-Object {
    Set-Variable -Name $_.Name -Value $window.FindName($_.Name)
}
$splashWindow.Close()

# ==========================
# Preload
# ==========================
$txtWinVersion = $window.FindName("txtWinVersion")
$txtSecureBoot = $window.FindName("txtSecureBoot")
$txtTPM        = $window.FindName("txtTPM")
$txtSecureBoot.Text = "Secure Boot: $secureBootStatus"
$txtTPM.Text        = "TPM State: $tpmStatus"
$cmbGameList      = $window.FindName("cmbGameList")
$btnApplyGameTweak = $window.FindName("btnApplyGameTweak")
$txtGameStatus     = $window.FindName("txtGameStatus")
$txtUser = $window.FindName("txtUser")
$txtCPU  = $window.FindName("txtCPU")
$txtRAM  = $window.FindName("txtRAM")
$txtGPU  = $window.FindName("txtGPU")
$txtBit  = $window.FindName("txtBit")
$txtSSD  = $window.FindName("txtSSD")
$txtUser.Text = "User        : $env:USERNAME"

# Windows Version
try {
    $os = Get-CimInstance Win32_OperatingSystem
    $build = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").CurrentBuild
    $winVersion = "$($os.Caption) Build $build"
}
catch {
    $winVersion = "Unknown Windows Version"
}

# CPU
$cpu = Get-WmiObject Win32_Processor | Select-Object -First 1
$txtCPU.Text = "CPU         : $($cpu.Name)"

# RAM
$ramBytes = (Get-WmiObject Win32_ComputerSystem).TotalPhysicalMemory
$ramGB = [math]::Round($ramBytes / 1GB, 2)
$txtRAM.Text = "RAM         : $ramGB GB"

# GPU
$gpu = (Get-WmiObject Win32_VideoController | Select-Object -First 1).Name
$txtGPU.Text = "GPU         : $gpu"

# System Bit
$os = Get-WmiObject Win32_OperatingSystem
$txtBit.Text = "System Bit  : $($os.OSArchitecture)"


# Cari semua SSD
$ssds = Get-CimInstance Win32_DiskDrive | Where-Object {
    $_.MediaType -like "*SSD*" -or $_.Model -match "SSD" -or $_.Capabilities -contains 3
}

# Kalau tidak ada SSD spesifik, fallback ke semua disk Non-Rotational (tidak berputar)
if (-not $ssds) {
    $ssds = Get-CimInstance Win32_DiskDrive | Where-Object { $_.SpindleSpeed -eq $null }
}

# Buat TextBlock baru untuk SSD
$txtSSD = New-Object System.Windows.Controls.TextBlock
$txtSSD.FontWeight = "Bold"
$txtSSD.Margin = "0,5,0,5"

if ($ssds) {
    $ssdInfo = ""
    $i = 1
    foreach ($ssd in $ssds) {
        $sizeGB = [math]::Round($ssd.Size/1GB)
        $ssdInfo += "SSD $i : $($ssd.Model) ($sizeGB GB)`n"
        $i++
    }
    $txtSSD.Text = $ssdInfo
} else {
    $txtSSD.Text = "SSD : Not Found"
}

# Tambahkan TextBlock ke parent Grid / StackPanel di tab System Information
$parent = $window.FindName("txtWinVersion").Parent
$parent.Children.Add($txtSSD)

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

$GameList = @{
    "Wuthering Waves"       = "Client-Win64-Shipping"
    "Valorant" = "VALORANT-Win64-Shipping"
    "Delta Force" = "DeltaForceClient-Win64-Shipping"
    "Counter-Strike 2"      = "cs2"
    "Arknights Enfield"     = "Endfield"
    "Girls Frontline 2: Exilium" = "GF2_Exilium"
    "Zenless Zone Zero"     = "ZenlessZoneZero"
    "Genshin Impact" = "GenshinImpact"
    "Honkai Star Rail" = "StarRail"
}

# Clear ComboBox and add games
$cmbGameList.Items.Clear()
foreach ($game in $GameList.Keys) {
    $cmbGameList.Items.Add($game)
}

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

$txtSecureBoot = $window.FindName("txtSecureBoot")
$txtTPM        = $window.FindName("txtTPM")

if ($txtSecureBoot) { $txtSecureBoot.Text = "Secure Boot: $secureBootStatus" }
if ($txtTPM)        { $txtTPM.Text        = "TPM State: $tpmStatus" }
$btnCopilotToggle = $window.FindName("btnCopilotToggle")

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

$global:GameProcessName = $null

$gameTimer = New-Object System.Windows.Threading.DispatcherTimer
$gameTimer.Interval = [TimeSpan]::FromSeconds(2)

$gameTimer.Add_Tick({

    if ($global:GameProcessName) {

        $proc = Get-Process -Name $global:GameProcessName -ErrorAction SilentlyContinue

        if ($proc) {

            try {
                $proc.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::High
                $txtGameStatus.Text = "$($proc.ProcessName) detected → Priority HIGH"
            }
            catch {}

        }
        else {
            $txtGameStatus.Text = "Waiting for game..."
        }

    }

})

$cmbAdapterList = $window.FindName("cmbAdapterList")
# === Ambil semua control DNS ===
$btnCloudflare = $window.FindName("btnCloudflare")
$btnGoogle      = $window.FindName("btnGoogle")
$btnOpenDNS     = $window.FindName("btnOpenDNS")
$btnDHCP        = $window.FindName("btnDHCP")
$txtPrimaryDNS  = $window.FindName("txtPrimaryDNS")
$txtSecondaryDNS = $window.FindName("txtSecondaryDNS")
$cmbDNSPreset   = $window.FindName("cmbDNSPreset")

$cmbDNSPreset.Add_SelectionChanged({

    $selected = $cmbDNSPreset.SelectedItem.Content

    switch ($selected) {

        "Automatic (DHCP)" {
            $adapter = Get-NetAdapter |
                       Where-Object {$_.Status -eq "Up"} |
                       Select-Object -First 1

            if ($adapter) {
                netsh interface ipv4 set dns name="$($adapter.Name)" dhcp | Out-Null
                ipconfig /flushdns | Out-Null
            }

            $txtPrimaryDNS.Text = ""
            $txtSecondaryDNS.Text = ""
        }

        "Cloudflare" {
            $txtPrimaryDNS.Text = "1.1.1.1"
            $txtSecondaryDNS.Text = "1.0.0.1"
        }

        "Google DNS" {
            $txtPrimaryDNS.Text = "8.8.8.8"
            $txtSecondaryDNS.Text = "8.8.4.4"
        }

        "OpenDNS" {
            $txtPrimaryDNS.Text = "208.67.222.222"
            $txtSecondaryDNS.Text = "208.67.220.220"
        }

        "Quad9" {
            $txtPrimaryDNS.Text = "9.9.9.9"
            $txtSecondaryDNS.Text = "149.112.112.112"
        }

        "AdGuard" {
            $txtPrimaryDNS.Text = "94.140.14.14"
            $txtSecondaryDNS.Text = "94.140.15.15"
        }

    }

})
$cmbAdapterList.Add_SelectionChanged({
    Refresh-DNSUI
})
# ==========================
# Functions
# ==========================
function Update-CopilotButton {

    if (Get-Command Get-CopilotStatus -ErrorAction SilentlyContinue) {
        if (Get-CopilotStatus) {
            $btnCopilotToggle.Content = "Disable Copilot"
        }
        else {
            $btnCopilotToggle.Content = "Enable Copilot"
        }
    }
    else {
        # PS 5.1 tidak ada Copilot, tombol tetap tampil "Enable Copilot" atau bisa disable saja
        $btnCopilotToggle.Content = "Enable Copilot (PS5.1)"
    }
}

Update-CopilotButton

function Show-Progress {
    $progressBar.Value = 0
    1..100 | ForEach-Object {
        $progressBar.Value = $_
        Start-Sleep -Milliseconds 5
    }
}

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
        [System.Windows.Forms.MessageBox]::Show("Failed to disable Microsoft AI.","Error")
    }
}

function Disable-GameBar {
    try {
        New-Item -Path "HKCU:\Software\Microsoft\GameBar" -Force | Out-Null
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "AllowAutoGameMode" -Value 0 -Force
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "ShowStartupPanel" -Value 0 -Force
        [System.Windows.Forms.MessageBox]::Show("Game Bar disabled.","Success")
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Failed to disable Game Bar.","Error")
    }
}

function Disable-RSS {
    try {
        netsh int tcp set global rss=disabled | Out-Null
        netsh int tcp set global autotuninglevel=disabled | Out-Null
        netsh int tcp set global chimney=disabled | Out-Null
        [System.Windows.Forms.MessageBox]::Show("RSS & low latency applied.","Success")
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Failed to disable RSS.","Error")
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
    Stop-Service bits -ErrorAction SilentlyContinue
    Set-Service bits -StartupType Disabled
    [System.Windows.Forms.MessageBox]::Show("Windows Update disabled.","Success")
}

function Enable-WU {
    Start-Service wuauserv -ErrorAction SilentlyContinue
    Set-Service wuauserv -StartupType Enabled
    Start-Service bits -ErrorAction SilentlyContinue
    Set-Service bits -StartupType Enabled
    [System.Windows.Forms.MessageBox]::Show("Windows Update enabled.","Success")
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
        [System.Windows.Forms.MessageBox]::Show("Failed to disable Reserved Storage.","Error")
    }
}

function Remove-NvidiaTelemetry {
    try {
        Stop-Service "NvTelemetryContainer" -ErrorAction SilentlyContinue
        Set-Service "NvTelemetryContainer" -StartupType Disabled -ErrorAction SilentlyContinue
        [System.Windows.Forms.MessageBox]::Show("NVIDIA Telemetry disabled.","Success")
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Failed to disable NVIDIA Telemetry.","Error")
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
        [System.Windows.Forms.MessageBox]::Show("Failed to restart PC.","Error")
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
        [System.Windows.Forms.MessageBox]::Show("Failed to disable Error Reporting.","Error")
    }
}

function Load-Adapters {

    $cmbAdapterList.Items.Clear()

    $adapters = Get-NetAdapter |
                Where-Object { $_.Status -ne "Disabled" }

    foreach ($adapter in $adapters) {
        $cmbAdapterList.Items.Add("$($adapter.InterfaceIndex) - $($adapter.Name)")
    }

    # Auto select active adapter (yang punya default route)
    $active = Get-NetRoute -DestinationPrefix "0.0.0.0/0" |
              Sort-Object RouteMetric |
              Select-Object -First 1

    if ($active) {
        $match = $cmbAdapterList.Items |
                 Where-Object { $_ -like "$($active.InterfaceIndex) -*" }

        if ($match) {
            $cmbAdapterList.SelectedItem = $match
        }
    }
}

Load-Adapters

function Get-ActiveAdapter {

    if ($cmbAdapterList.SelectedItem) {
        $index = ($cmbAdapterList.SelectedItem -split " - ")[0]
        return [int]$index
    }

    # fallback auto detect
    $route = Get-NetRoute -DestinationPrefix "0.0.0.0/0" |
             Sort-Object RouteMetric |
             Select-Object -First 1

    if ($route) {
        return $route.InterfaceIndex
    }

    return $null
}

# Set Custom DNS
function Set-CustomDNS {
    param(
        [string]$PrimaryDNS,
        [string]$SecondaryDNS
    )

    $adapter = Get-NetAdapter |
               Where-Object {$_.Status -eq "Up"} |
               Select-Object -First 1

    if (-not $adapter) {
        Write-Host "❌ No active adapter found."
        return
    }

    $name = $adapter.Name

    netsh interface ipv4 set dns name="$name" static $PrimaryDNS primary | Out-Null

    if ($SecondaryDNS) {
        netsh interface ipv4 add dns name="$name" $SecondaryDNS index=2 | Out-Null
    }

    ipconfig /flushdns | Out-Null

    [System.Windows.Forms.MessageBox]::Show("DNS Successfully Applied.","Success")

    Refresh-DNSUI
}

function Apply-DNSPreset {
    param(
        [string]$Primary,
        [string]$Secondary
    )

    $txtPrimaryDNS.Text = $Primary
    $txtSecondaryDNS.Text = $Secondary

    Set-CustomDNS -PrimaryDNS $Primary -SecondaryDNS $Secondary
}

function Reset-DNS {

    try {

        $adapter = Get-NetAdapter |
                   Where-Object {$_.Status -eq "Up"} |
                   Select-Object -First 1

        if (-not $adapter) {
            [System.Windows.Forms.MessageBox]::Show("No active adapter found.","Error")
            return
        }

        Set-DnsClientServerAddress -InterfaceIndex $adapter.InterfaceIndex -ResetServerAddresses

        ipconfig /flushdns | Out-Null

        [System.Windows.Forms.MessageBox]::Show("DNS Reverted to Automatic (DHCP).","Success")
    }
    catch {
        [System.Windows.Forms.MessageBox]::Show("Failed to reset DNS.","Error")
    }
}

function Refresh-DNSUI {

    $index = Get-ActiveAdapter
    if (-not $index) { return }

    $dns4 = Get-DnsClientServerAddress -InterfaceIndex $index -AddressFamily IPv4
    $dns6 = Get-DnsClientServerAddress -InterfaceIndex $index -AddressFamily IPv6

    if ($dns4.ServerAddresses.Count -ge 1) {
        $txtDNS1.Text = "Primary DNS  : $($dns4.ServerAddresses[0])"
    } else {
        $txtDNS1.Text = "Primary DNS  : Not Set"
    }

    if ($dns4.ServerAddresses.Count -ge 2) {
        $txtDNS2.Text = "Secondary DNS: $($dns4.ServerAddresses[1])"
    } else {
        $txtDNS2.Text = "Secondary DNS: Not Set"
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

function Open-RestorePointWindow {
    try {
        Start-Process "SystemPropertiesProtection.exe"
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Failed to open Restore Point window.","Error")
    }
}

function Create-RestorePoint {
    param(
        [switch]$nonInteractive
    )

    #check vss service first
    $vssService = Get-Service -Name 'VSS' -ErrorAction SilentlyContinue
    if ($vssService -and $vssService.StartType -eq 'Disabled') {
        try {
            Write-Status -msg 'Enabling VSS Service...'
            Set-Service -Name 'VSS' -StartupType Manual -ErrorAction Stop
            Start-Service -Name 'VSS' -ErrorAction Stop
        }
        catch {
            Write-Status -msg 'Unable to Start VSS Service... Can not create restore point!' -errorOutput
            return
        }
        
    }
    #enable system protection to allow restore points
    $restoreEnabled = Get-ComputerRestorePoint -ErrorAction SilentlyContinue
    if (!$restoreEnabled) {
        Write-Status -msg 'Enabling Restore Points on System...'
        Enable-ComputerRestore -Drive "$env:SystemDrive\" 
    }

    
    if ($nonInteractive) {
        #allow restore point to be created even if one was just made
        $restoreFreqPath = 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore'
        $restoreFreqKey = 'SystemRestorePointCreationFrequency'
        $currentValue = (Get-ItemProperty -Path $restoreFreqPath -Name $restoreFreqKey -ErrorAction SilentlyContinue).$restoreFreqKey
        if ($currentValue -ne 0) {
            Set-ItemProperty -Path $restoreFreqPath -Name $restoreFreqKey -Value 0 -Force
        }

        $restorePointName = "RemoveWindowsAI-$(Get-Date -Format 'yyyy-MM-dd')"
        Write-Status -msg "Creating Restore Point: [$restorePointName]"
        Write-Status -msg 'This may take a moment...please wait'
        Checkpoint-Computer -Description $restorePointName -RestorePointType 'MODIFY_SETTINGS' 
    }
    else {
        Write-Status -msg 'Opening Restore Point Dialog...'
        try {
            $proc = Start-Process 'SystemPropertiesProtection.exe' -ErrorAction Stop -PassThru
        }
        catch {
            $proc = Start-Process 'C:\Windows\System32\control.exe' -ArgumentList 'sysdm.cpl ,4' -PassThru
        }
        #click configure on the window
        Start-Sleep 1
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.SendKeys]::SendWait('%c') 
        Wait-Process -Id $proc.Id
    }

}

$global:GameMonitorTimer = $null
$global:TargetProcessName = $null
$global:BoostedProcess = $null

function Start-GameTweak {
    param($processName)

    # Stop previous monitor if exists
    if ($global:GameMonitorTimer) {
        $global:GameMonitorTimer.Stop()
        $global:GameMonitorTimer = $null
    }

    $global:TargetProcessName = $processName
    $global:BoostedProcess = $null
    $global:QoSName = "GameBoost_$processName"

    $txtGameStatus.Text = "Waiting for game process: $processName ..."

    # DispatcherTimer cek tiap 2 detik
    $timer = New-Object System.Windows.Threading.DispatcherTimer
    $timer.Interval = [TimeSpan]::FromSeconds(2)

    $timer.Add_Tick({
        try {
            $proc = Get-Process | Where-Object { $_.ProcessName -like "*$global:TargetProcessName*" } | Select-Object -First 1

            if ($proc -and -not $global:BoostedProcess) {
                # GAME Detected

                # PRIORITY
                try {
                    $proc.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::High
                } catch {}

                # NETWORK BOOST (QoS)
                try {
                    # Delete if exist (anti duplicate)
                    Get-NetQosPolicy -Name $global:QoSName -ErrorAction SilentlyContinue | Remove-NetQosPolicy -Confirm:$false

                    # Buat QoS baru
                    New-NetQosPolicy -Name $global:QoSName `
                        -AppPathNameMatchCondition $proc.Path `
                        -NetworkProfile All `
                        -PriorityValue8021Action 6 `
                        -DSCPAction 46

                } catch {}

                $global:BoostedProcess = $proc
                $txtGameStatus.Text = "Game detected: $($proc.ProcessName) → BOOST ON"
            }
            elseif (-not $proc -and $global:BoostedProcess) {
                # ❌ GAME CLOSED

                # Reset priority
                try {
                    $global:BoostedProcess.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::Normal
                } catch {}

                # Hapus QoS
                try {
                    Remove-NetQosPolicy -Name $global:QoSName -Confirm:$false
                } catch {}

                $txtGameStatus.Text = "Game closed → BOOST OFF"
                $global:BoostedProcess = $null
            }
            elseif (-not $proc) {
                $txtGameStatus.Text = "Waiting for game process: $processName ..."
            }

        } catch {
            $txtGameStatus.Text = "Error detecting process."
        }
    })

    $timer.Start()
    $global:GameMonitorTimer = $timer
}

function Get-CopilotStatus {
    try {
        $path = "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot"
        if (-not (Test-Path $path)) { return $true }  # default aktif
        $value = Get-ItemProperty -Path $path -Name "TurnOffWindowsCopilot" -ErrorAction Stop
        if ($value.TurnOffWindowsCopilot -eq 1) { return $false }
        return $true
    } catch {
        return $true
    }
}

function Toggle-Copilot {
    try {
        $path = "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot"
        if (!(Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
        if (Get-CopilotStatus) {
            Set-ItemProperty -Path $path -Name "TurnOffWindowsCopilot" -Type DWord -Value 1
        } else {
            Remove-ItemProperty -Path $path -Name "TurnOffWindowsCopilot" -ErrorAction SilentlyContinue
        }
    } catch {
        [System.Windows.MessageBox]::Show("Failed to toggle Copilot settings.","Error")
    }
}

function Safe-GetCopilotStatus {
    if (Get-Command Get-CopilotStatus -ErrorAction SilentlyContinue) {
        return Get-CopilotStatus
    } else {
        return $false   # default jika fungsi tidak tersedia
    }
}

function Update-CopilotButton {
    if ($btnCopilotToggle -eq $null) { return }
    if (Safe-GetCopilotStatus) {
        $btnCopilotToggle.Content = "Disable Copilot"
    } else {
        $btnCopilotToggle.Content = "Enable Copilot"
    }
}

# ==========================
# Handlers
# ==========================
$btnTelemetry.Add_Click({ Safe-Debloat })
$btnBgSync.Add_Click({ Disable-BackgroundSync })
$btnAI.Add_Click({ Disable-MicrosoftAI })
$btnGameBar.Add_Click({ Disable-GameBar })
$btnRSS.Add_Click({ Disable-RSS })
$btnSuperfetch.Add_Click({ Disable-Superfetch })
$btnWU.Add_Click({ Disable-WU })

$btnTemp.Add_Click({ Clean-Temp })
$btnReserved.Add_Click({ Disable-ReservedStorage })
$btnNvidia.Add_Click({ Remove-NvidiaTelemetry })

$btnPerf.Add_Click({ Performance-Boost })
$btnBalance.Add_Click({ Balance-Power })

##$btnRestore.Add_Click({ Open-RestorePointWindow })
$btnRestore.Add_Click({ Create-RestorePoint })

$btnRestart.Add_Click({ Restart-PC })
$btnErrorReport.Add_Click({ Disable-ErrorReporting })

$btnGitHub.Add_Click({ Start-Process "https://github.com/mellowzy365/TweakyLITE" })
$btnSaweria.Add_Click({ Start-Process "https://saweria.co/mellowzy" })
$btnSetDNS.Add_Click({Set-CustomDNS $txtPrimaryDNS.Text $txtSecondaryDNS.Text})
$btnFlushDNS.Add_Click({ Flush-DNSUI })
$btnOpenNetConn.Add_Click({ Open-NetworkConnections })
$btnCopilotToggle = $window.FindName("btnCopilotToggle")
if ($btnCopilotToggle) {
    Update-CopilotButton

    $btnCopilotToggle.Add_Click({
        if (Get-Command Toggle-Copilot -ErrorAction SilentlyContinue) {
            Toggle-Copilot
            Update-CopilotButton
            [System.Windows.MessageBox]::Show("Copilot setting updated.`nRestart Explorer or PC to apply changes.")
        } else {
            [System.Windows.MessageBox]::Show("Toggle-Copilot function not found.`nSkipping.")
        }
    })
}
$btnApplyGameTweak.Add_Click({
    if (-not $cmbGameList.SelectedItem) {
        [System.Windows.MessageBox]::Show("Please select a game first.")
        return
    }

    $selectedGame = $cmbGameList.SelectedItem.ToString().Trim()
    $processName = $GameList.Keys | Where-Object { $_.Trim() -ieq $selectedGame } | ForEach-Object { $GameList[$_] }

    if (-not $processName) {
        [System.Windows.MessageBox]::Show("Game process name not found in list.","Error")
        $txtGameStatus.Text = "Error: process name not found"
        return
    }

    # Jalankan auto-detect tweak
    Start-GameTweak $processName
})

# ==========================
# Add ToolTips Automatically
# ==========================
$tooltipMap = @{
    btnTelemetry = "Telemetry service track and log usage sending feedback data for analysis to Microsoft"
    btnBgSync    = "Turn off background synchronization apps for free up RAM"
    btnAI       = "Disable Microsoft AI features (Like Cortana)"
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
    btnCopilotToggle = "For enable/disable copilot (require restart after this)"
}

foreach ($btnName in $tooltipMap.Keys) {
    $btn = Get-Variable -Name $btnName -ErrorAction SilentlyContinue
    if ($btn) {
        $btn.Value.ToolTip = $tooltipMap[$btnName]
    }
}

$window.Add_Closing({
    if ($global:GameMonitorTimer) {
        $global:GameMonitorTimer.Stop()
    }
})
Refresh-DNSUI

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
v1.04
• Bug Fixes
• Remove some unused features
• Added Preset DNS Custom

v1.03
• Improved Ai Manager
• Improved Game Tweaks

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
# Show Window
# ==========================
$window.ShowDialog() | Out-Null
