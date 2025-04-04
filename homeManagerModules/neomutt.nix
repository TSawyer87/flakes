{...}: {
  programs.neomutt.enable = true;
  accounts.email.accounts = let
    transipMail = {
      neomutt.enable = true;
      imap = {
        host = "imap.transip.email";
        port = 993;
        tls.useStartTls = true;
      };
      smtp = {
        host = "smtp.transip.email";
        port = 465;
        tls.useStartTls = true;
      };
    };
  in {
    # manually create: `mkdir -p ~/Maildir/<EMAIL>/Inbox/{cur,new,tmp}`

    "kiara@bij1.org" =
      transipMail
      // {
        address = "kiara@bij1.org";
        userName = "kiara@bij1.org";
        realName = "Kiara Grouwstra";
        passwordCommand = "keepassxc-cli show -sa password ~/Nextcloud/keepass.kdbx 'BIJ1/transip.email'";
        primary = true;
      };

    "ict@bij1.org" =
      transipMail
      // {
        address = "ict@bij1.org";
        userName = "ict@bij1.org";
        realName = "BIJ1 ICT";
        passwordCommand = "pass bij1-shared/admin/transip.email/ict | head -n 1";
      };
  };
}
