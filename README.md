[SFNuGet](https://github.com/Azure/SFNuGet) lets you package up Service Fabric services as NuGet packages. Unfortunately it copies your service package into your `ApplicationPackageRoot` and you'll end up committing it to source control.

SFNuGet.Build is designed to be added as a dependency to your SFNuGet package (via [a custom Package.xml]([SFNuGet packages](https://github.com/Azure/SFNuGet#use-a-custom-packagexml-file)). It'll add itself as some MSBuild targets and copy your service packages at _package_ time.

# Creating a package
Using SFNuGet...
1. Modify your Package.xml to refer to `SFNuGet.Build` as a dependency 
   ```
    <dependencies>
        <dependency id="SFNuGet.Build" version="1.0.0" />
    </dependencies>
    ```
1. Package your service [as normal](https://github.com/Azure/SFNuGet#package-a-service-fabric-as-a-nuget-package).

# Using a package
1. Install the package [as normal](https://github.com/Azure/SFNuGet/blob/master/docs/Tutorial-AuthorService.md#use-the-nuget-package)
1. If this is the first SFNuGet package you're adding to your application, update the .sfproj to import the SFNuGet.Build targets.
   Open the application project (.sfproj) in a text editor and import the MSBuild targets by adding this line:
   ```
   <Import Project="..\packages\SFNuGet.Build.1.0.0-alpha-00\build\SFNuGet.Build.targets" Condition="Exists('..\packages\SFNuGet.Build.1.0.0-alpha-00\build\SFNuGet.Build.targets')" />
   ```
   and to warn people who haven't run package restoration, add this under the `ValidateMSBuildFiles` target:
   ```
   <Error Condition="!Exists('..\packages\SFNuGet.Build.1.0.0-alpha-00\build\SFNuGet.Build.targets')" Text="Unable to find the '..\packages\SFNuGet.Build.1.0.0-alpha-00\build\SFNuGet.Build.targets' file. Please restore the 'SFNuGet.Build' NuGet package" />
   ```

   You should end up with this:
   ```
    <Import Project="$(ApplicationProjectTargetsPath)" Condition="Exists('$(ApplicationProjectTargetsPath)')" />
    <Import Project="..\packages\Microsoft.VisualStudio.Azure.Fabric.MSBuild.1.6.2\build\Microsoft.VisualStudio.Azure.Fabric.Application.targets" Condition="Exists('..\packages\Microsoft.VisualStudio.Azure.Fabric.MSBuild.1.6.2\build\Microsoft.VisualStudio.Azure.Fabric.Application.targets')" />
    <Import Project="..\packages\SFNuGet.Build.1.0.0-alpha-00\build\SFNuGet.Build.targets" Condition="Exists('..\packages\SFNuGet.Build.1.0.0-alpha-00\build\SFNuGet.Build.targets')" />
    <Target Name="ValidateMSBuildFiles">
        <Error Condition="!Exists('..\packages\Microsoft.VisualStudio.Azure.Fabric.MSBuild.1.6.2\build\Microsoft.VisualStudio.Azure.Fabric.Application.props')" Text="Unable to find the '..\packages\Microsoft.VisualStudio.Azure.Fabric.MSBuild.1.6.2\build\Microsoft.VisualStudio.Azure.Fabric.Application.props' file. Please restore the 'Microsoft.VisualStudio.Azure.Fabric.MSBuild' Nuget package" />
        <Error Condition="!Exists('..\packages\Microsoft.VisualStudio.Azure.Fabric.MSBuild.1.6.2\build\Microsoft.VisualStudio.Azure.Fabric.Application.targets')" Text="Unable to find the '..\packages\Microsoft.VisualStudio.Azure.Fabric.MSBuild.1.6.2\build\Microsoft.VisualStudio.Azure.Fabric.Application.targets' file. Please restore the 'Microsoft.VisualStudio.Azure.Fabric.MSBuild' Nuget package" />
        <Error Condition="!Exists('..\packages\SFNuGet.Build.1.0.0-alpha-00\build\SFNuGet.Build.targets')" Text="Unable to find the '..\packages\SFNuGet.Build.1.0.0-alpha-00\build\SFNuGet.Build.targets' file. Please restore the 'SFNuGet.Build' NuGet package" />
    </Target>
    ```

   (I'd love this to be automated, [but-](https://github.com/Azure/service-fabric-issues/issues/558#issuecomment-356816774).)


   # Known issues
   * You gotta do that messy editing of your .sfproj
   * Your service package is still copied into `ApplicationPackageRoot` when it's first installed. (The first time you package the application, it'll get cleaned up. I haven't figured out how to stop SFNuGet from copying them without making a breaking change to it.)