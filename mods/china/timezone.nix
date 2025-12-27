{ lib, ... }:

{
  time.timeZone = lib.mkForce "Asia/Shanghai";
}
