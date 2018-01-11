# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license.

# Runs every time a package is installed in a project

param($installPath, $toolsPath, $package, $project)

# $installPath is the path to the folder where the package is installed.
# $toolsPath is the path to the tools directory in the folder where the package is installed.
# $package is a reference to the package object.
# $project is a reference to the project the package was installed to.

# From https://stackoverflow.com/a/12150199/1259408

#$TargetsFile = 'SFNuGet.Build.targets'
#$TargetsPath = $ToolsPath | Join-Path -ChildPath "..\build\$TargetsFile"

#Write-Host "Found target: $TargetsPath"
#Write-Host "Selected project: $($Project.FullName)"
#$project | gm

#Add-Type -AssemblyName 'Microsoft.Build, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'

#$MSBProject = [Microsoft.Build.Evaluation.ProjectCollection]::GlobalProjectCollection.GetLoadedProjects($Project.FullName) |
#    Select-Object -First 1

#$ProjectUri = New-Object -TypeName Uri -ArgumentList "file://$($Project.FullName)"
#$TargetUri = New-Object -TypeName Uri -ArgumentList "file://$TargetsPath"

#$RelativePath = $ProjectUri.MakeRelativeUri($TargetUri) -replace '/','\'

#Write-Host "Generated relative path: $RelativePath"

#$ExistingImports = $MSBProject.Xml.Imports |
#    Where-Object { $_.Project -like "*\$TargetsFile" }
#if ($ExistingImports) {
#    $ExistingImports | 
#        ForEach-Object {
#            Write-Host "Removing existing import: $($_.Label)"
#            $MSBProject.Xml.RemoveChild($_) | Out-Null
#        }
#}

#$ExistingImports

#Write-Host "Adding new import: $RelativePath"
#$Import = $MSBProject.Xml.AddImport($RelativePath)
#$Import.Condition = "Exists('$relativePath')"

##$target = $MSBProject.Xml.AddTarget("EnsureOctoPackImported")
##$target.BeforeTargets = "BeforeBuild"
##$target.Condition = "'`$(OctoPackImported)' == ''"

#$MSBProject.Save()
#$Project.Save("$($Project.FullName)")