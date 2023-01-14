<h1>Matchify</h1>
Tool for DoS attacks on Wi-Fi network infrastructure using aircrack-ng.

This script uses regular expressions to filter by the target network, however it is recommended to pass the full ESSID as an argument for more precision, once done, enter the primary network interface, optionally the channel option can be omitted (if not known).

---
<ul>
  <li>Simple and Powerfull</li>
  <li>Easy use</li>
</ul>

---

## Using 

> Before using matchify you needed install tool aircrack-ng 

<code>sudo apt-get install aircrack-ng</code>

## install

> Once installed airckrack-ng tool you can clone this bash script

```git clone https://www.github.com/christianymoon/matchify.git```

> set execute permissions to script

`sudo chmod +x matchify.sh`

## Examples

`./matchify.sh essid interface channel`
