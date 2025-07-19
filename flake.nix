   Nix

{
  description = "Моя конфигурация NixOS с Hyprland";

  inputs = {
    # Официальный репозиторий Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Используем нестабильную ветку для свежих пакетов

    # Репозиторий Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; # Home Manager будет использовать ту же версию Nixpkgs, что и основная система
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    # Определяем системные конфигурации NixOS
    nixosConfigurations = {
      # Наша основная конфигурация для 'nixos' хоста
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux"; # Или aarch64-linux для ARM, если у вас ARM-устройство
        modules = [
          # Импортируем наш основной файл конфигурации NixOS
          ./configuration.nix

          # Включаем Home Manager как модуль NixOS
          home-manager.nixosModules.home-manager
        ];
        specialArgs = { inherit inputs; }; # Передаем inputs в модули, чтобы они могли к ним обращаться
      };
    };
  };
}

