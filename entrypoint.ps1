function Main()
{
  [OutputType([Void])]
  param ([string[]] $inputArgs)

  # Remove any arg that is empty or whitespace. This removes empty strings that are passed from the action.yml.
  # This is a workaround to deal with non-required action inputs when this script is called via the action.yml.
  $argsAsList = [Collections.Generic.List[String]]::new()
  foreach ($arg in $inputArgs)
  {
    if(![string]::IsNullOrWhiteSpace($arg))
    {
      $argsAsList.Add($arg)
    }
  }
  
  Write-Output "Executing: dotnet '/app/MarkdownLinkCheckLogParserCli.dll' $argsAsList"
  $output = dotnet '/app/MarkdownLinkCheckLogParserCli.dll' $argsAsList
  
  if($LASTEXITCODE -ne 0 ) {
      Write-Output "::error::Markdown link check log parser didn't complete successfully. See the step's log for more details."
      exit $LASTEXITCODE
  }
  
  Write-Output "::set-output name=mlc-result::$output"  
}

# invoke entrypoint function
Main $args
