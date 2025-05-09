{ config, pkgs, lib, name, ... }:

{
  ##########
  ## HOME ##
  ##########

  nixpkgs.config.allowUnfree = true;
  
  home.stateVersion = "24.11";

  home = {
    username = name;
    homeDirectory = "/home/${config.home.username}";
  };

  #########
  ## XDG ##
  #########

  xdg = {
    userDirs = {
      enable = true;
      music = "${config.home.homeDirectory}/Nextcloud/Music";
      pictures = "${config.home.homeDirectory}/Nextcloud/Pictures";
      videos = "${config.home.homeDirectory}/Nextcloud/Videos";
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      desktop = "${config.home.homeDirectory}/Desktop";
    };
    # mimeApps = {
    #   enable = true;
    #   defaultApplications = {
    #     "x-terminal-emulator" = ["kitty.desktop"];
    #   };
    # };
  };

  ###########
  ## SHELL ##
  ###########

  programs.zsh = {
    enable = true;
    autocd = true;
  };

  programs.fastfetch = {
    enable = true;
    package = pkgs.fastfetch;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "packages"
        "display"
        "brightness"
        "sound"
        "de"
        "wm"
        "cpu"
        "gpu"
        "disk"
        "memory"
        "swap"
        "wifi"
        "bluetooth"
        "localip"
        "battery"
        "poweradapter"
        "datetime"
      ];
    };
  };

  programs.ranger = {
    enable = true;
    extraPackages = [ pkgs.ueberzugpp ];
    settings = {
      show_hidden = true;
      preview_images_method = "ueberzug";
    };
  };

  #############
  ## DEVELOP ##
  #############

  programs.git = {
    enable = true;
    userName = "Solhvemjsun";
    userEmail = "solhvemjsun@gmail.com";
  };

  ##############
  ## HYPRLAND ##
  ##############

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
    plugins = with pkgs; [
      hyprlandPlugins.hyprexpo
      hyprlandPlugins.hypr-dynamic-cursors
      hyprlandPlugins.hyprscroller
    ];
    settings = lib.mkOptionDefault {
      # Define Variables
      "$terminal" = "kitty";
      "$fileManager" = "nemo";
      "$menu" = "wofi --show drun -i -p Search ";
      "$runlist" = "wofi --show run -i -p Run ";

      # Monitor
      monitor = [
        ", preferred, auto, auto"
        "desc:Samsung Electric Company Odyssey G8 HCNX400855, 3840x2160@240, auto, auto"
      ];

      # Autostart
      exec-once = [
        "systemctl --user start hyprpolkitagent"
        "systemd-inhibit --who=\"Hyprland config\" --why=\"wofi power menu keybind\" --what=handle-power-key --mode=block sleep infinity & echo $! > /tmp/.hyprland-systemd-inhibit"
      ];
      exec-shutdown = "kill -9 \"$(cat /tmp/.hyprland-systemd-inhibit)";

      # Environment Variables
      env = [
        "HYPRCURSOR_SIZE,64"
        "XCURSOR_SIZE,64"
        "HYPRSHOT_DIR,Nextcloud/Pictures/Screenshots"
      ];

      # Look and Feel
      general = { 
        layout = "scroller";
        gaps_in = "0";
        gaps_out = "0";
        border_size = "2";
        "col.active_border" = "rgba(88ffffff) rgba(4488ffff) 45deg";
        "col.inactive_border" = "rgba(393939ff)";
        allow_tearing = "false";
      };

      decoration = {
        rounding = "0";
        active_opacity = "1.0";
        inactive_opacity = "1.0";
        blur = {
          enabled = "false";
        };
      };

      animations = {
        enabled = "true";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      master = {
        new_status = "master";
      };

      misc = {
        disable_hyprland_logo = "true";
        background_color = "0x000000";
        vfr = "true";
      };

      # Plugins
      plugin = {
        dynamic-cursors = {
          enabled = "true";
          mode = "stretch";
          stretch = {
            limit = "3000";
            function = "quadratic";
          };
        };
        scroller = {
          focus_wrap = "true";

          gesture_scroll_fingers = "3";
          gesture_scroll_distance = "42";

          gesture_overview_fingers = "4";
          gesture_overview_distance = "5";
          overview_scale_content = "true";

          colum_default_width = "onehalf";
          colum_widths = "onethird onehalf twothirds";

          window_default_height = "one";
          window_heights = "onethird onehalf twothirds one";
        };
        hyprexpo = {
          enable_gesture = "false";
          gesture_fingers = "4";
        };
      };
      
      # Input
      gestures = {
        workspace_swipe = "false";
      };
      binds = {
        allow_workspace_cycles = "yes";
      };

      input = {
        kb_layout = "us";
        kb_model = "";
        kb_rules = "";
        follow_mouse = "1";
        touchpad = {
          natural_scroll = "false";
        };
      };

      # Keybindings
      # Set modificators
      "$mainMod" = "SUPER";
      "$ctrlMod" = "CONTROL";
      "$shiftMod" = "SHIFT";
      "$altMod" = "ALT";

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging on touchpad
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bind = [
        # Move focus with mouse scroller
        "$mainMod, mouse_up, scroller:movefocus, d"
        "$mainMod, mouse_down, scroller:movefocus, u"
        "$mainMod, mouse_left, scroller:movefocus, l"
        "$mainMod, mouse_right, scroller:movefocus, r"

        # Move focus with mainMod + WASD
        "$mainMod, W, scroller:movefocus, u"
        "$mainMod, S, scroller:movefocus, d"
        "$mainMod, A, scroller:movefocus, l"
        "$mainMod, D, scroller:movefocus, r"

        # Move window with mainMod + shiftMod + WASDZX
        "$mainMod $shiftMod, W, scroller:movewindow, u"
        "$mainMod $shiftMod, S, scroller:movewindow, d"
        "$mainMod $shiftMod, A, scroller:movewindow, l"
        "$mainMod $shiftMod, D, scroller:movewindow, r"
        "$mainMod $shiftMod, X, scroller:admitwindow"
        "$mainMod $shiftMod, C, scroller:expelwindow"

        # Align active window with mainMod + ctrl + WASDC
        "$mainMod $ctrlMod, W, scroller:alignwindow, u"
        "$mainMod $ctrlMod, S, scroller:alignwindow, d"
        "$mainMod $ctrlMod, A, scroller:alignwindow, l"
        "$mainMod $ctrlMod, D, scroller:alignwindow, r"
        "$mainMod $ctrlMod, Z, scroller:alignwindow, m"

        # Set mode by Z
        "$mainMod, Z, scroller:setmode, row"
        "$mainMod $shiftMod, Z, scroller:setmode, column"

        # Resize window with mainMod + XCF
        "$mainMod, X, scroller:cycleheight, +1"
        "$mainMod, C, scroller:cyclewidth, +1"

        "$mainMod, F, fullscreen"
        "$mainMod $shiftMod, F, togglefloating"
        
        # Change mode with mainMod + ctrl + ZX
        "$mainMod $ctrlMod, X, scroller:setmode, row"
        "$mainMod $ctrlMod, C, scroller:setmode, col"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Tag for overviews
        "$mainMod, tab, scroller:toggleoverview"
        "$mainMod $shiftMod, tab, hyprexpo:expo, toggle"
        "$mainMod $ctrlMod, tab, scroller:jump"

        # Open and close windows
        "$mainMod, Q, killactive,"
        "$mainMod, E, exec, $menu"
        "$mainMod $shiftMod, E, exec, $runlist"
        "$mainMod, T, exec, $terminal"
        "$mainMod, Return, exec, $terminal"

        # Poweroff menu
        ", XF86PowerOff, exec, zsh -c 'action=$(echo -e \"Shutdown\\nReboot\\nLock\\nLogout\\nSuspend\" | wofi --dmenu --prompt \"Power Menu\" --width 300 --height 200); case \"$action\" in \"Lock\") hyprlock;; \"Logout\") hyprctl dispatch exit;; \"Suspend\") systemctl suspend;; \"Reboot\") systemctl reboot;; \"Shutdown\") systemctl poweroff;; esac'"

        # Function keys
        ", xf86AudioLowerVolume, exec, zsh -c 'pamixer -d 10 && notify-send \"Volume $(pamixer --get-volume)%\" -t 500'"
        ", xf86AudioRaiseVolume, exec, zsh -c 'pamixer -i 10 && notify-send \"Volume $(pamixer --get-volume)%\" -t 500'"

        ", xf86AudioMute, exec, zsh -c 'pamixer -t && notify-send \"Mute $(pamixer --get-mute)\" -t 500'"
        ", xf86AudioMicMute, exec, zsh -c 'pamixer --default-source -m && notify-send \"Mic mute\" -t 500'"
        ", xf86AudioPlay, exec, playerctl play-pause"

        ", xf86MonBrightnessDown, exec, zsh -c 'brightnessctl set 10%- && notify-send \"Brightness $(light)%\" -t 500'"
        ", xf86MonBrightnessUp, exec, zsh -c 'brightnessctl set 10%+ && notify-send \"Brightness $(light)%\" -t 500'"

        ", Print, exec, hyprshot -m output"
        "$shiftMod, Print, exec, hyprshot -m region"
        "$mainMod, Print, exec, hyprshot -m window"

        ", xf86Display, exec, $menu" # To change
      ];

      windowrulev2 = [
        # "suppressevent maximize, class:.*"
        "float,title:^(floatingkitty)$"
        "center,title:^(floatingkitty)$"
        "size 1600 900,title:^(floatingkitty)$"
      ];

    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {};
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "pidof hyprlock || hyprlock";
      };
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        enable_fingerprint = true;
      };

      auth = {
        fingerprint = {
          enabled = true;
          ready_message = "";
          present_message = "";
        };
      };

      background = [
        {
          color = "rgb(0, 0, 0)";
        }
      ];

      input-field = {
        size = "1000, 400";
        position = "0, 0";
        monitor = "";
        dots_center = true;
        dots_size = 0.5;
        dots_text_format = "*";
        rounding = 0;
        font_color = "rgb(255, 255, 255)";
        inner_color = "rgba(0, 0, 0, 0)";
        check_color = "rgba(0, 191, 191, 0)";
        fade_on_empty = false;
        placeholder_text = "I";
        fail_text = "Authentication Failed";
        fail_timeout = "2000";
        fail_transition = "5000";
        outline_thickness = 0;
        swap_font_color = true;
      };
    };
  };

  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
    };
  };

  programs.wofi = {
    enable = true;
    package = pkgs.wofi;
    settings = {};
    style = ''
      #window { background-color: rgba(0,0,0,0); }
      #input { 
        margin: 5px;
        border: 2px solid rgba(136,223,255,1);
        background-color: black;
        color: white;
      }
      #scroll {
        margin: 5px;
        border: 2px solid rgba(136,223,255,1);
        background-color: black;
      }
      #text { 
        margin: 5px;
        color: white
      }
      #text:selected {
        margin: 5px;
        color: black
      }
      #entry:selected {
        background-color: rgba(31,95,127,0.5);
        background: linear-gradient(45deg, #88ffff, #4488ff);
      }
    '';
  };

  services.mako = {
    enable = true;
    settings = {
      background-color = "#000000FF";
      border-size = 2;
      border-color = "#00FFFFFF";
    };
  };

  ############
  ## STYLIX ##
  ############

  stylix = {
    enable = true;
    polarity = "dark";
    image = ./nixos.png;
    imageScalingMode = "fit";
    cursor = {
      package = (pkgs.callPackage ../../pkgs/breeze-hacked-cursor-theme-hyprcursor/package.nix {});
      name = "Breeze_Hacked";
      size = 64;
    };
    iconTheme = {
      enable = true;
      dark = "Sweet-Rainbow";
      light = "Sweet-Rainbow";
    };
    base16Scheme = {
      system = "base24";
      name = "Eclipse";
      author = "Sol";
      variant = "dark";
      base00 = "000000";
      base01 = "131313";
      base02 = "2a3141";
      base03 = "343d50";
      base04 = "d6dae4";
      base05 = "c1c8d7";
      base06 = "e3e6ed";
      base07 = "ffffff";
      base08 = "f71118";
      base09 = "ecb90f";
      base0A = "0f80d5";
      base0B = "2cc55d";
      base0C = "0f80d5";
      base0D = "2a84d2";
      base0E = "4e59b7";
      base0F = "7b080c";
      base10 = "0a0a0a";
      base11 = "060606";
      base12 = "ff0000";
      base13 = "ffff00";
      base14 = "00ff00";
      base15 = "00ffff";
      base16 = "0000ff";
      base17 = "ff00ff";
    };
    targets = {
      kitty.enable = false;
      mako.enable = false;
      wofi.enable = false;
      hyprland.enable = false;
      hyprlock.enable = false;
      nixvim.enable = false;
    };
  };

}
