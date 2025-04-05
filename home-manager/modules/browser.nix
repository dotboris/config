{...}: let
  extensions = [
    {
      slug = "darkreader";
      id = "addon@darkreader.org";
    }
    {
      slug = "display-_anchors";
      id = "display-anchors@robwu.nl";
    }
    {
      slug = "keepassxc-browser";
      id = "keepassxc-browser@keepassxc.org";
    }
    {
      slug = "offline-qr-code-generator";
      id = "offline-qr-code@rugk.github.io";
    }
    {
      slug = "prod-guard";
      id = "dev-prog-guard-extension@example.com";
    }
    {
      slug = "sidebery";
      id = "{3c078156-979c-498b-8990-85f7987dd929}";
    }
    {
      slug = "react-devtools";
      id = "@react-devtools";
    }
    {
      slug = "ublock-origin";
      id = "uBlock0@raymondhill.net";
    }
    {
      slug = "xifr";
      id = "{5e71bed2-2b15-40b8-a15b-ba89563aaf73}";
    }
  ];
in {
  programs.librewolf = {
    enable = true;
    languagePacks = [
      "en-CA"
      "en-US"
      "fr"
    ];
    settings = {
      "webgl.disabled" = false;
      "privacy.resistFingerprinting" = false;
      "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = false;
      "privacy.clearOnShutdown_v2.cache" = false;
      "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
      "network.cookie.lifetimePolicy" = 0;

      # Enable extensions to be installed from mozilla's site
      # "extensions.postDownloadThirdPartyPrompt" = true;
      # "extensions.webextensions.restrictedDomains" = "accounts-static.cdn.mozilla.net,accounts.firefox.com,addons.cdn.mozilla.net,addons.mozilla.org,api.accounts.firefox.com,content.cdn.mozilla.net,discovery.addons.mozilla.org,install.mozilla.org,oauth.accounts.firefox.com,profile.accounts.firefox.com,support.mozilla.org,sync.services.mozilla.com";
    };

    policies.ExtensionSettings =
      {
        DisableSystemAddonUpdate = false;
      }
      // builtins.listToAttrs (
        map (ext: {
          name = ext.id;
          value = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/${ext.slug}/latest.xpi";
          };
        })
        extensions
      );
  };
}
