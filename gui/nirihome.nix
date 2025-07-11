{
  config,
  pkgs,
  ...
}:

{
  ##########
  ## NIRI ##
  ##########

  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      environment = {
        DISPLAY = ":0"; # xwayland-satellite
        QT_QPA_PLATFORM = "wayland";
      };

      prefer-no-csd = true;

      # xwayland-satellite = {
      #   enable = true;
      #   path = lib.getExe pkgs.xwayland-satellite-unstable;
      # };

      # Misc
      hotkey-overlay = {
        # hide-not-bound = true;
        skip-at-startup = true;
      };
      overview = {
        # zoom = 0.75;
        backdrop-color = "#000000";
      };

      input = {
        # mod-key = "Super";
        power-key-handling.enable = true;
        focus-follows-mouse.enable = true;
        keyboard = {
          numlock = true;
          repeat-delay = 500;
          repeat-rate = 25;
          track-layout = "global";
        };
        mouse = {
          enable = true;
          accel-profile = "adaptive";
          natural-scroll = false;
          scroll-method = "two-finger";
        };
        touchpad = {
          enable = true;
          accel-profile = "adaptive";
          click-method = "clickfinger";
          disabled-on-external-mouse = false;
          drag = false;
          drag-lock = false;
          dwt = false; # disable while typing
          dwtp = false; # disable while using trackpoint
          natural-scroll = false;
          scroll-method = "two-finger";
          tap = true; # tap-to-click
        };
        warp-mouse-to-focus.enable = true;
        workspace-auto-back-and-forth = false;
      };

      cursor = {
        hide-after-inactive-ms = 3000;
        hide-when-typing = true;
        size = 64;
        theme = "miku-cursor";
      };

      outputs = {
        "XPS" = {
          name = "Sharp Corporation 0x1551 Unknown";
          mode = {
            width = 3840;
            height = 2160;
            refresh = 59.994;
          };
          scale = 1.5;
          transform.rotation = 0;
          position = {
            x = 0;
            y = 0;
          };
          background-color = "#000000";
          backdrop-color = "#000000";
          focus-at-startup = true;
        };

        "G8" = {
          name = "Samsung Electric Company Odyssey G8 HCNX400855";
          mode = {
            width = 3840;
            height = 2160;
            refresh = 240.000;
          };
          variable-refresh-rate = "on-demand";
          scale = 1;
          transform.rotation = 0;
          position = {
            x = 0;
            y = 0;
          };
          background-color = "#000000";
          backdrop-color = "#000000";
          focus-at-startup = true;
        };

        "Ehomewei" = {
          name = "Invalid Vendor Codename - RTK Monitor 0x01010101";
          mode = {
            width = 2560;
            height = 1600;
            refresh = 60.000;
          };
          scale = 1.6;
          transform.rotation = 270;
          position = {
            x = -1000;
            y = 0;
          };
          background-color = "#000000";
          backdrop-color = "#000000";
        };
      };

      layout = {
        border = {
          enable = true;
          width = 2;
          active.gradient = {
            angle = 45;
            from = "#88ffff";
            to = "#4488ff";
            relative-to = "window";
          };
          inactive.gradient = {
            angle = 45;
            from = "#448888";
            to = "#224488";
            relative-to = "workspace-view";
          };
          # inactive.color = "#393939"
          # urgent = {};
        };
        focus-ring.enable = false;
        insert-hint = {
          enable = true;
          display.gradient = {
            angle = 45;
            from = "#448888";
            to = "#224488";
            relative-to = "window";
          };
        };
        tab-indicator = {
          enable = false;
        };
        gaps = 0;
        struts = {
          bottom = 0;
          left = 0;
          right = 0;
          top = 0;
        };

        default-column-width = { };
        # default-column-width.proportion = 1. / 3.;
        preset-column-widths = [
          { proportion = 1. / 3.; }
          { proportion = 1. / 2.; }
          { proportion = 2. / 3.; }
          { proportion = 1.; }
        ];
        preset-window-heights = [
          { proportion = 1. / 3.; }
          { proportion = 1. / 2.; }
          { proportion = 2. / 3.; }
          { proportion = 1.; }
        ];
        always-center-single-column = true;
        center-focused-column = "never";
        default-column-display = "normal";
        empty-workspace-above-first = false;
      };

      window-rules = [
        {
          matches = [
            {
              app-id = "firefox$";
              title = "^Picture-in-Picture$";
            }
          ];
          open-floating = true;
        }
        # {
        #   matches = [
        #     {
        #       app-id = "^org\.gnome\.World\.Secrets$";
        #     }
        #   ];
        #   block-out-from = "screen-capture";
        # }
      ];

      # layer-rules = { };

      animations = {
        enable = true;
        # WIP
      };

      gestures = {
        # WIP
        hot-corners.enable = false;
      };

      spawn-at-startup = [
        { command = [ "xwayland-satellite" ]; }
        { command = [ "hyprpaper" ]; }
        { command = [ "mako" ]; }
        {
          command = [ "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1" ];
        }
        { command = [ "${pkgs.xwayland-satellite}/bin/xwayland-satellite" ]; }
      ];

      # To-do: add suspend actions
      switch-events = {
        lid-close.action.spawn = "hyprlock";
        # lid-open.action.spawn = "hyprlock";
        # tablet-mode-on.action.spawn = ["gsettings" "set" "org.gnome.desktop.a11y.applications" "screen-keyboard-enabled" "true"];
        # tablet-mode-off.action.spawn = ["gsettings" "set" "org.gnome.desktop.a11y.applications" "screen-keyboard-enabled" "false"];
      };

      binds =
        with config.lib.niri.actions;
        let
          exec = spawn "zsh" "-c";
        in
        {
          # Move focus with mouse scroller
          "Mod+WheelScrollUp".action = focus-window-up-or-column-left;
          "Mod+WheelScrollDown".action = focus-window-down-or-column-right;
          "Mod+WheelScrollLeft".action = focus-window-up-or-column-left;
          "Mod+WheelScrollRight".action = focus-window-down-or-column-right;

          # Move focus with mouse scroller
          "Mod+Shift+WheelScrollUp".action = move-window-up-or-to-workspace-up;
          "Mod+Shift+WheelScrollDown".action = move-window-down-or-to-workspace-down;
          "Mod+Shift+WheelScrollLeft".action = move-column-left-or-to-monitor-left;
          "Mod+Shift+WheelScrollRight".action = move-column-right-or-to-monitor-right;

          # Move focus with mainMod + WASD
          "Mod+W".action = focus-window-or-workspace-up;
          "Mod+S".action = focus-window-or-workspace-down;
          "Mod+A".action = focus-column-or-monitor-left;
          "Mod+D".action = focus-column-or-monitor-right;

          # Move window with mainMod + shiftMod + WASD
          "Mod+Shift+W".action = move-window-up-or-to-workspace-up;
          "Mod+Shift+S".action = move-window-down-or-to-workspace-down;
          "Mod+Shift+A".action = move-column-left-or-to-monitor-left;
          "Mod+Shift+D".action = move-column-right-or-to-monitor-right;

          # Admit/expel window with Mod+Shift+X/C
          "Mod+Shift+X".action = consume-or-expel-window-left;
          "Mod+Shift+C".action = consume-or-expel-window-right;

          # Resize window with mainMod + XCF
          "Mod+X".action = switch-preset-window-height;
          "Mod+C".action = switch-preset-column-width;

          "Mod+F".action = fullscreen-window;
          "Mod+Shift+F".action = toggle-window-floating;

          # Switch workspaces with mainMod + [0-9]
          "Mod+1".action.focus-workspace = 1;
          "Mod+2".action.focus-workspace = 2;
          "Mod+3".action.focus-workspace = 3;
          "Mod+4".action.focus-workspace = 4;
          "Mod+5".action.focus-workspace = 5;
          "Mod+6".action.focus-workspace = 6;
          "Mod+7".action.focus-workspace = 7;
          "Mod+8".action.focus-workspace = 8;
          "Mod+9".action.focus-workspace = 9;

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          "Mod+Shift+1".action.move-column-to-workspace = 1;
          "Mod+Shift+2".action.move-column-to-workspace = 2;
          "Mod+Shift+3".action.move-column-to-workspace = 3;
          "Mod+Shift+4".action.move-column-to-workspace = 4;
          "Mod+Shift+5".action.move-column-to-workspace = 5;
          "Mod+Shift+6".action.move-column-to-workspace = 6;
          "Mod+Shift+7".action.move-column-to-workspace = 7;
          "Mod+Shift+8".action.move-column-to-workspace = 8;
          "Mod+Shift+9".action.move-column-to-workspace = 9;

          # Tag for overviews
          "Mod+Tab".action = toggle-overview;

          # Open and close windows
          "Mod+Q".action = close-window;
          "Mod+E".action = exec "wofi --show drun -i -p Search";
          "Mod+T".action = spawn "kitty";
          "Mod+Return".action = spawn "kitty";

          # Poweroff menu
          "XF86PowerOff".action =
            exec "$(echo -e \"Shutdown\\nReboot\\nLock\\nLogout\\nSuspend\" | wofi --dmenu --prompt \"Power Menu\" --width 300 --height 200); case \"$action\" in \"Lock\") hyprlock;; \"Logout\") hyprctl dispatch exit;; \"Suspend\") systemctl suspend;; \"Reboot\") systemctl reboot;; \"Shutdown\") systemctl poweroff;; esac";

          # Function keys
          "XF86AudioLowerVolume".action =
            exec "pamixer -d 10 && notify-send \"Volume $(pamixer --get-volume)%\" -t 500";
          "Xf86AudioRaiseVolume".action =
            exec "pamixer -i 10 && notify-send \"Volume $(pamixer --get-volume)%\" -t 500";

          "XF86AudioMute".action = exec "pamixer -t && notify-send \"Mute $(pamixer --get-mute)\" -t 500";
          "XF86AudioMicMute".action = exec "pamixer --default-source -m && notify-send \"Mic mute\" -t 500";
          "XF86AudioPlay".action = spawn "playerctl play-pause";

          "XF86MonBrightnessDown".action =
            exec "brightnessctl set 10%- && notify-send \"Brightness $(light)%\" -t 500";
          "XF86MonBrightnessUp".action =
            exec "brightnessctl set 10%+ && notify-send \"Brightness $(light)%\" -t 500";

          "Print".action = screenshot { show-pointer = false; };
          "Shift+Print".action = screenshot { show-pointer = true; };
          "Mod+Print".action = screenshot-window { write-to-disk = true; };

          "XF86Display".action = suspend;

          "Mod+Shift+Slash".action = show-hotkey-overlay;
          "Ctrl+Alt+Delete".action = quit;
        };
    };
  };

  ##############
  ## PROGRAMS ##
  ##############

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

  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;
    settings = {
      ipc = "off";
      splash = false;
      preload = [
        "../../assets/nixos.png"
      ];
      wallpaper = [
        ",../../assets/nixos.png"
      ];
    };
  };

  # services.wpaperd = {
  #   enable = true;
  #   settings =
  # };

  programs.wofi = {
    enable = true;
    package = pkgs.wofi;
    settings = { };
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

}
