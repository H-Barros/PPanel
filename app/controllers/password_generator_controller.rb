class PasswordGeneratorController < ApplicationController
    require "rqrcode"

    def index
    qrcode = RQRCode::QRCode.new("#{self.request.base_url}#{new_intake_password_sector_form_path}")

    png = qrcode.as_png(
    bit_depth: 1,
    border_modules: 4,
    color_mode: ChunkyPNG::COLOR_GRAYSCALE,
    color: "black",
    file: nil,
    fill: "white",
    module_px_size: 6,
    resize_exactly_to: false,
    resize_gte_to: false,
    size: 600
    )

    IO.binwrite("app/assets/images/password-qrcode.png", png.to_s)
    end
end
