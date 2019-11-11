<#
    .Notes
    ==================================================================================
    == Author: Kausar Ayub                                                          ==
    == Contact: kausarayub@gmail.com                                                ==
    == Date: October 18, 2016                                                       ==
    == Does this code make changes: No                                              ==
    == This script gives the count of list items for all sites of a web application ==
    ==================================================================================
#>

#Declaring variables
$webURL = "https://www.MySharePointSite.com"
$elapsed = [System.Diagnostics.Stopwatch]::StartNew()

#Initializing the sharepoint objects
$webApp = Get-SPWebApplication $webURL

#Looping through all site collections
foreach($Site in $webApp.Sites){
    $SiteSize = $Site.Usage.Storage / 1MB
    $SiteCollectionName = $Site.RootWeb.Title
    Write-Host $SiteCollectionName -F Yellow
    
    #Looping through all sub sites
    foreach($SubSite in $Site.AllWebs){
      $SubSiteName = $SubSite.Name
      Write-Host "`t"$SubSiteName -F Yellow
      
      #Looing through all lists
      foreach($list in $SubSite.Lists){
        $ListName = $list.Title
        $ListItemCount = $list.Items.Count
        Write-Host "`t`t"$ListName ":" $ListItemCount
      }
    }
}
write-host "Total Elapsed Time: " $elapsed.Elapsed.ToString() -F Cyan
