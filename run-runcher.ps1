# Navigate to CraftRoot and run craftenv.ps1
Set-Location "C:\CraftRoot\craft"
& .\craftenv.ps1

# Navigate to runcher directory
Set-Location "E:\Git based Runcher\runcher"

# Run cargo
cargo run --bin runcher
