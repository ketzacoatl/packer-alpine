clean:
	rm -rf output-virtualbox-iso
	#rm -rf out
	#vagrant destroy

build:
	packer build alpine-iso-install.json

add-box:
	vagrant box add alpine-clean-3.6.1 out/alpine-clean-3.6.1.box
