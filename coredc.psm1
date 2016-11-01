Configuration ControlServ{
	param(
		[Parameter(Mandatory)]
		[PSCredential] $credential
		[PSCredential]$memecred
	)
	
	Import-DscResource -Module xActiveDirectory
	Import-DSCResource -ModuleName PSDesiredStateConfiguration
	
	Node localhost{
		LocalConfigurationManager {
			ConfigurationModeFrequency = 15
			ConfigurationMode = "ApplyAndAutocorrect"
		}
		WindowsFeature Hyperv{
			Name = "Hyper-v"
			Credential = $credential
			Ensure="Present"
			IncludeAllSubFeature=$true
		}
		WindowsFeature ADDS{
			Name = "AD-Domain-Services"
			Credential= $credential
			Ensure="Present"
			IncludeAllSubFeature = $true
		}
		xADDomain Setup{
			DomainName = "meme.com"
			DependsOn= "[WindowsFeature]ADDS"
		}
		xADDomainController Setup{
			DomainName= "meme.com"
			DomainAdministratorCredential= $memecred
			DependsOn = "[xADDomain]Setup"
		
		}
		
		
		
	}

}