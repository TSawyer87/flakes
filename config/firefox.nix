_: let
  lockFalse = {
    Value = false;
    Status = "locked";
  };
  lockTrue = {
    Value = true;
    Status = "locked";
  };
in {
  programs.firefox = {
    enable = true;
    languagePacks = ["en-US"];

    policies = {
      # Disable Telemetry and Studies
      DisableTelemetry = true;
      DisableFirefoxStudies = true;

      # Enable Tracking Protection
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = false;
        Fingerprinting = false;
      };

      # Disable various features
      DisablePocket = false;
      DisableFirefoxAccounts = false;
      DisableAccounts = false;
      DisableFirefoxScreenshots = true;

      # UI Modifications
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
      DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
      SearchBar = "unified"; # alternative: "separate"

      # Extensions Management
      ExtensionSettings = {
        "*".installation_mode = "blocked"; # Blocks all addons except those explicitly allowed below
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        };
        # "{d634138d-c276-4fc8-924b-40a0ea21d284}" = { # 1Password
        #   install_url =
        #     "https://addons.mozilla.org/firefox/downloads/latest/1password-x-password-manager/latest.xpi";
        #   installation_mode = "force_installed";
        # };
      };

      # Preferences
      Preferences = {
        "browser.contentblocking.category" = {
          Value = "strict";
          Status = "locked";
        };
        "extensions.pocket.enabled" = lockFalse;
        "extensions.screenshots.disabled" = lockTrue;
        "browser.topsites.contile.enabled" = lockFalse;
        "browser.formfill.enable" = lockFalse;
        "browser.search.suggest.enabled" = lockFalse;
        "browser.search.suggest.enabled.private" = lockFalse;
        "browser.urlbar.suggest.searches" = lockFalse;
        "browser.urlbar.showSearchSuggestionsFirst" = lockFalse;
        "browser.newtabpage.activity-stream.feeds.section.topstories" =
          lockFalse;
        "browser.newtabpage.activity-stream.feeds.snippets" = lockFalse;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" =
          lockFalse;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" =
          lockFalse;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" =
          lockFalse;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" =
          lockFalse;
        "browser.newtabpage.activity-stream.showSponsored" = lockFalse;
        "browser.newtabpage.activity-stream.system.showSponsored" = lockFalse;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = lockFalse;
      };
    };
  };
}
