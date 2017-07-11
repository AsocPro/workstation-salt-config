RunEssentialsDaily:
  schedule.present:
    - function: state.sls
    - job_args:
      - essentials
    - day: 1
