
#  Fastfile.swift
#  AvanceProyecto
#  Created by David Moreno on 2025-09-27.

default_platform(:ios)

platform :ios do
  desc "Lane para CI: compilar y correr pruebas"
  lane :ci do
    build_app(
      scheme: "AvanceProyecto"
    )
    run_tests(
      scheme: "AvanceProyecto"
    )
  end
end

