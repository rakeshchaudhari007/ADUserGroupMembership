$array = @()
$Adgroups = Get-ADGroup -Filter *
foreach($group in $Adgroups){
    $users = Get-ADGroupMember -Identity $group.samaccountname
    foreach($user in $users){
        if($user.objectClass -eq "user"){
             #$username = Get-ADUser -Identity $user.SamAccountName | Where-Object {$_.Enabled -eq "True"}
           $username = Get-ADUser -identity $user.SamAccountName
               $array += [pscustomobject]@{
               username = $username.Name
               groupname = $group.Name
               UserStatus = $username.enabled
              }
        }

     }
}

foreach($activeuser in $array){

   if( $activeuser.UserStatus -eq "True"){
        $activeuser 
   }
}
