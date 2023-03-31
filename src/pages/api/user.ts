import type { NextApiRequest, NextApiResponse } from 'next'
import users from "./db/users.json";
type IData = {
  message: string
  user?: object
}

export default function handler(
  req: NextApiRequest,
  res: NextApiResponse<IData>
) {
  if (req.body && typeof req.body === 'string')
    req.body = JSON.parse(req.body);
  if (req.method === 'GET') {
    const address = req.query.address as string;
    const user = users.users.find(user => user?.address.toLowerCase() == address.toLowerCase())
    if (!user) return res.status(400).json({ message: "USER_NOT_EXIST" });
    return res.status(200).json({ message: 'OK', user: user })
  } else {
    return res.status(400).json({ message: "METHOT_NOT_FOUND" });
  }
}
