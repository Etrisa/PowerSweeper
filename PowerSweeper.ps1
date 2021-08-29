# Your working directory
$workingPath = 'C:\Users\Etrisa\Desktop\PowerSweeper'

# Add the working directory to the environment path.
# This is required for the ChromeDriver to work.
if (($env:Path -split ';') -notcontains $workingPath) {
    $env:Path += ";$workingPath"
}

#Import Selenium to PowerShell using the Import-Module cmdlet.
Import-Module "$($workingPath)\WebDriver.dll"

# Create a new ChromeDriver Object instance.
$ChromeDriver = New-Object OpenQA.Selenium.Chrome.ChromeDriver

#Set the fkn size of the window.
$ChromeDriver.Manage().Window.Size = "2560,1440"

#Move the fkn window.
$ChromeDriver.Manage().Window.Position = "2559,0"

# Launch a browser and go to URL
$ChromeDriver.Navigate().GoToURL('https://play.minesweeperflags.net/#/')

#Wait for element fuction, call with
#WaitFor(' XPATH HERE ')
function WaitFor {
    param (
        $Element
    )
    $Wait = $false
    while ($Wait -eq $false) {
        Start-Sleep 1
        try {
            if ($ChromeDriver.FindElementByCssSelector($Element)) {
                $Wait = $true
                Write-Host 'Element found'
            } 
        }
        catch {
            Write-Host 'Element not found'
            Write-Host $Element
        }
    }
}

#Click Settings
WaitFor('#app > div.application--wrap > nav > div > div.v-menu.v-menu--inline > div > button > div > i')
$ChromeDriver.FindElementByCssSelector('#app > div.application--wrap > nav > div > div.v-menu.v-menu--inline > div > button > div > i').Click()

#Click Dark Theme
WaitFor('#app > div.v-menu__content.theme--light.menuable__content__active > div > div.v-input.v-input--selection-controls.v-input--checkbox.theme--light > div > div.v-input__slot > div > div')
$ChromeDriver.FindElementByCssSelector('#app > div.v-menu__content.theme--light.menuable__content__active > div > div.v-input.v-input--selection-controls.v-input--checkbox.theme--light > div > div.v-input__slot > div > div').Click()

#Click Guest
WaitFor('#app > div.application--wrap > main > div > div > div > div.layout.justify-center.row > button')
$ChromeDriver.FindElementByCssSelector('#app > div.application--wrap > main > div > div > div > div.layout.justify-center.row > button').Click()

#Click to challenge AI_Complete_Idiot
WaitFor('#app > div.application--wrap > main > div > div > div.layout.row.wrap.align-space-around > div:nth-child(1) > div > div:nth-child(3) > div > div > div > div > div:nth-child(2) > div > div > div > div > div.layout.align-center.justify-end.fill-height > button')
$ChromeDriver.FindElementByCssSelector('#app > div.application--wrap > main > div > div > div.layout.row.wrap.align-space-around > div:nth-child(1) > div > div:nth-child(3) > div > div > div > div > div:nth-child(2) > div > div > div > div > div.layout.align-center.justify-end.fill-height > button').Click()

#Wait for playing field.
WaitFor('#app > div.application--wrap > main > div > div > div.map-flex > div > div > div > div.flex.xs12.lg6.xl6.map-flex > div > div.map-square > div > div > div > img:nth-child(1)')

#AI RETARDED! :D
for ($i = 1; $i -lt 257; $i++) {
    $Random = Get-Random -Minimum 1 -Maximum 2 #257
    Write-Host "Random is" $Random

    $Guessed = @()
    if ($Guessed.Contains($Random)) {
        return
    }
    $Guessed += $Random

    
    $ChromeDriver.FindElementByCssSelector('#app > div.application--wrap > main > div > div > div.map-flex > div > div > div > div.flex.xs12.lg6.xl6.map-flex > div > div.map-square > div > div > div > img:nth-child(' + $Random + ')').Click()
}

#$ChromeDriver.FindElementByCssSelector(' JS PATH ')



