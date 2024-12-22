class Isync < Formula
  desc "Synchronize a maildir with an IMAP server -- with Cyrus SASL"
  homepage "https://isync.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/isync/isync/1.5.0/isync-1.5.0.tar.gz"
  sha256 "a0c81e109387bf279da161453103399e77946afecf5c51f9413c5e773557f78d"
  license "GPL-2.0-or-later"

  head do
    url "https://git.code.sf.net/p/isync/isync.git", branch: "master"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  depends_on "berkeley-db@5"
  depends_on "cyrus-sasl"
  depends_on "openssl@3"

  uses_from_macos "zlib"

  def install
    system "./autogen.sh" if build.head?
    system "./configure",
      *std_configure_args,
      "--disable-silent-rules",
      "--with-sasl=#{HOMEBREW_PREFIX}/opt/cyrus-sasl"
    system "make", "install"
  end

  service do
    run [opt_bin/"mbsync", "-a"]
    run_type :interval
    interval 300
    keep_alive false
    environment_variables PATH: std_service_path_env
    log_path File::NULL
    error_log_path File::NULL
  end

  test do
    system bin/"mbsync-get-cert", "duckduckgo.com:443"
  end
end
