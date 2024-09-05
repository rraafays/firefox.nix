{ pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
in
{
  imports = [ "${home-manager}/nixos" ];

  home-manager.users.raf = {
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
            darkreader
            newtab-adapter
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
          };
        };
      };
    };
  };
}
