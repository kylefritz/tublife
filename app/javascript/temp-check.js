const ewelink = require("ewelink-api");

function toFahrenheit(degreesCelsius) {
  return (degreesCelsius * 9.0) / 5.0 + 32;
}

async function getDevices(email) {
  const password = process.env.EWELINK_PASSWORD;
  if (!password) {
    throw "set env variable EWELINK_PASSWORD";
  }

  const connection = new ewelink({ email, password });
  const devices = await connection.getDevices();

  return devices.map((device) => {
    const { name, params, deviceid: deviceId } = device;
    const { currentTemperature: degreesCelsius, switch: switchState } = params;
    const degreesF = toFahrenheit(degreesCelsius);
    // console.log(`${name} temp ${degreesF}°F pump: ${switchState}`);

    return { device_name: name, temp_f: degreesF, pump: switchState };
  });
}

async function main() {
  const emails = (process.env.EWELINK_EMAILS || "").split(",");
  if (!emails.length) {
    throw "set env variable EWELINK_EMAILS";
  }

  const allDevices = [];
  for (const email of emails) {
    const devices = await getDevices(email);
    devices.forEach((d) => allDevices.push(d));
  }

  console.log(JSON.stringify(allDevices));
}

main();
