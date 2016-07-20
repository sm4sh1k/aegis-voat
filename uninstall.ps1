<#
.notes 
  * original author mark berry (c) 2015 mcb systems all rights reserved free for personal or commercial use may not be sold
  * modified for use in aegis v1.14+ by https://voat.co/u/thepower on 02.23.2016
#>
$computername = $env:computername
$kbnumbers=971033,2882822,2902907,2922324,2952664,2976978,2977759,2990214,3012973,3014460,3015249,3021917,3022345,3035583,3042058,3044374,3046480,3058168,3064683,3065987,3065988,3068708,3072318,3074677,3075249,3075851,3075853,3080149,3081437,3081454,3081954,3083324,3083325,3083710,3083711,3086255,3088195,3090045,3093983,3102810,3102812,3112343,3112336,3123862,3135445,3135449,3138612,3138615,3139929,3146449,3150513,3173040
$x=0
$hotfixes = get-wmiobject -computername $computername -class win32_quickfixengineering | select hotfixid
foreach ($kbnumber in $kbnumbers) {
  $kbid = "kb"+$kbnumber
  if ($hotfixes -match $kbid) {
    $x=1
    " - uninstall kb$kbnumber"
    start-process wusa.exe "/kb:$kbnumber /norestart /quiet /uninstall" -nonewwindow -wait
  }
}
if ($x -eq 0) {
  " - no updates required to be uninstalled"
}
