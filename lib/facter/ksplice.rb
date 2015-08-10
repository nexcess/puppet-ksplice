Facter.add(:ksplice_kernelrelease) do
  setcode '/usr/bin/uptrack-uname -r'
end

Facter.add(:ksplice_kernelversion) do
  setcode do
    Facter.value(:ksplice_kernelrelease).split('-')[0]
  end
end

Facter.add(:ksplice_kernelmajversion) do
  setcode do
    Facter.value(:ksplice_kernelversion).split('.')[0..1].join('.')
  end
end
