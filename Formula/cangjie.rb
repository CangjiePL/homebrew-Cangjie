class Cangjie < Formula
  desc "Cangjie input method engine"
  homepage "https://github.com/18630931025/cangjie"
  version "0.53.18"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      # 本地测试路径
      url "https://gitcode.com/weixin_46244104/cangjie-mac/releases/download/cangjie-0.53.18/Cangjie-0.53.18-darwin_aarch64.tar.gz"
      sha256 "0044b6810ef78b19ec451ef0514a8d4de1634ae36e4680746e89b329b381991e"

      # 正式发布路径 (发布时取消注释)
      # url "https://github.com/18630931025/cangjie/releases/download/v#{version}/Cangjie-#{version}-darwin_aarch64.tar.gz"
      # sha256 "0044b6810ef78b19ec451ef0514a8d4de1634ae36e4680746e89b329b381991e"
    else
      url "https://gitcode.com/weixin_46244104/cangjie-mac/releases/download/cangjie-0.53.18/Cangjie-0.53.18-darwin_x64.tar.gz"
      sha256 "2ce777c02c5c0c264ce6a2a1bbaf46ed981698c43cd967b096d2ecc116c29801"
    end
  end

  def install
    # 直接安装到标准目录（不再使用 libexec）
    prefix.install Dir["*"]  # 安装所有内容到 /usr/local/Cellar/cangjie/0.53.18/

    # 确保可执行文件在 PATH 中
    bin.install "bin/cangjie" if File.exist?("bin/cangjie")

    # 安装库文件到标准目录
    lib.install Dir["lib/*.dylib"] if File.directory?("lib")

    # 如果需要，可以安装其他资源文件
    share.install "share" if File.directory?("share")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cangjie --version")
  end
end
