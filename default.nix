{ pkgs, ... }:

let
  USER = "raf";
in
{
  environment.variables = {
    BROWSER = "firefox";
    MOZ_WEBRENDER = 0;
    MOZ_ENABLE_WAYLAND = 1;
    MOZ_DISABLE_GMP_SANDBOX = 1;
    MOZ_DISABLE_ACCELERATED_XSHM = 1;
    MOZ_DISABLE_E10S = 1;
    MOZ_FORCE_DISABLE_E10S = 1;
    MOZ_WEBRENDER_THREADS = 2;
    MOZ_NUM_CONTENT_PROCESSES = 2;
  };

  home-manager.users.${USER} = {
    programs.firefox = {
      enable = true;
      profiles = {
        default = {
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            vimium
            sponsorblock
            youtube-recommended-videos
            scroll_anywhere
            newtab-adapter
            plasma-integration
            read-aloud
            theater-mode-for-youtube
          ];
          userChrome = ''
            #TabsToolbar { visibility: collapse !important; }
            #main-window:not([customizing]) #navigator-toolbox:not(:focus-within):not(:hover){
            margin-top: -45px;
            }
          '';
          settings = {
            "browser.startup.homepage" = "https://www.google.co.uk";
            "browser.search.region" = "GB";
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "app.normandy.first_run" = false;
            "app.shield.optoutstudies.enabled" = false;
            "app.update.channel" = "default";
            "browser.urlbar.quickactions.enabled" = false;
            "browser.urlbar.quickactions.showPrefs" = false;
            "browser.urlbar.shortcuts.quickactions" = false;
            "browser.urlbar.suggest.quickactions" = false;
            "dom.forms.autocomplete.formatautofill" = false;
            "extensions.update.enabled" = false;
            "extensions.webcompat.enable_picture_in_picture_override" = true;
            "extensions.webcompat.enable_shims" = true;
            "extensions.webcompat.perform_injections" = true;
            "extensions.webcompat.perform_ua_overrides" = true;
            "privacy.donottrackheader.enabled" = true;
            "signon.rememberSignons" = false;
            "browser.formfill.enable" = false;
            "signon.autofillForms" = false;
            "extensions.formautofill.addresses.enabled" = false;
            "extensions.formautofill.creditCards.enabled" = false;
            "extensions.formautofill.hueristics.enabled" = false;
            "extensions.pocket.enabled" = false;
            "layers.acceleration.force-enabled" = true;
          };
        };
      };
    };
  };
}
