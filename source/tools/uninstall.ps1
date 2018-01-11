# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license.

# Runs every time a package is uninstalled

param($installPath, $toolsPath, $package, $project)

# $installPath is the path to the folder where the package is installed.
# $toolsPath is the path to the tools directory in the folder where the package is installed.
# $package is a reference to the package object.
# $project is a reference to the project the package was installed to.

# From https://stackoverflow.com/a/12150199/1259408

#$TargetsFile = 'SFNuGet.Build.targets'

#Add-Type -AssemblyName 'Microsoft.Build, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'

#$MSBProject = [Microsoft.Build.Evaluation.ProjectCollection]::GlobalProjectCollection.GetLoadedProjects($Project.FullName) |
#    Select-Object -First 1

#$ExistingImports = $MSBProject.Xml.Imports |
#    Where-Object { $_.Project -like "*\$TargetsFile" }
#if ($ExistingImports) {
#    $ExistingImports | 
#        ForEach-Object {
#            $MSBProject.Xml.RemoveChild($_) | Out-Null
#        }
#    $Project.Save("")
#}