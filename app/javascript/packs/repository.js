import axios from "axios";

const Domain = gon.BASE_URL;
const baseURL = `${Domain}/api`;

export default axios.create({
  baseURL,
  headers: {
    "X-Requested-With": "XMLHttpRequest",
    "X-CSRF-TOKEN": document
      .querySelector('meta[name="csrf-token"]')
      .getAttribute("content")
  }
});
